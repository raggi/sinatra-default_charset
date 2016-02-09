require 'sinatra/base'

module Sinatra
  module DefaultCharset
    VERSION = '0.2.0'

    DEFAULT_FALLBACK = 'utf-8'

    charset = if defined?(Encoding) && Encoding.respond_to?(:default_external)
      Encoding.default_external.to_s.downcase
    else
      case $kcode
      when /n/i
        DEFAULT_FALLBACK
      when /e/i
        'euc-jp'
      when /s/i
        'shift_jis'
      when /u/i
        'utf-8'
      else
        DEFAULT_FALLBACK
      end
    end

    DEFAULT_CHARSET = charset

    # Defaults to
    def content_type(type = nil, params = {})
      if params.include?(:charset)
        params.delete(:charset) if params[:charset].nil?
      else
        params[:charset] = settings.default_charset
      end
      super
    end

    def self.registered(app)
      app.set :default_charset, DEFAULT_CHARSET
      app.helpers self
      # re-default it so that we've always got a charset set
      app.before { content_type :html }
    end
  end
end
