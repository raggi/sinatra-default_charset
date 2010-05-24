require 'sinatra/base'

module Sinatra
  module DefaultCharset
    VERSION = '0.1.0'

    def content_type(type, params = {})
      params[:charset] ||= settings.default_charset
      super
    end

    def self.registered(app)
      app.set :default_charset, 'utf-8'
      app.helpers self
      # re-default it so that we've always got a charset set
      app.before { content_type :html }
    end
  end
end