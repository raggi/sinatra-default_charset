require "sinatra/default_charset"
require 'minitest/unit'
require 'rack/test'

class TestSinatra; end
class TestSinatra::TestDefaultCharset < MiniTest::Unit::TestCase
  class TestApp < Sinatra::Base
    register Sinatra::DefaultCharset

    get '/' do
      "hello world\n"
    end
    
    get '/thing.xml' do
      content_type :xml
      'thing'
    end
    
    get '/custom.xml' do
      content_type :xml, :charset => 'iso-8859-1'
      'custom'
    end
    
    get '/none' do
      content_type :html, :charset => nil
      'none'
    end
  end

  include Rack::Test::Methods

  attr_reader :app

  def test_defaults
    # This test assumes you haven't set $kcode or Encoding.default_external to
    # non-default values.
    @app = TestApp.new
    get '/'
    assert last_response.ok?
    assert_match 'charset=utf-8', last_response['Content-Type']
    assert_equal "hello world\n", last_response.body
  end
  
  def test_custom_content_type
    @app = TestApp.new
    get '/thing.xml'
    assert_match 'charset=utf-8', last_response['Content-Type']
    assert_match 'application/xml', last_response['Content-Type']
    assert_equal 'thing', last_response.body
  end
  
  def test_custom_content_type_and_charset
    @app = TestApp.new
    get '/custom.xml'
    assert_match 'charset=iso-8859-1', last_response['Content-Type']
    assert_match 'application/xml', last_response['Content-Type']
    assert_equal 'custom', last_response.body
  end
  
  def test_no_charset
    @app = TestApp.new
    get '/none'
    refute_match 'charset=', last_response['Content-Type']
    assert_match 'text/html', last_response['Content-Type']
    assert_equal 'none', last_response.body
  end
  
  class Windows < TestApp
    set :default_charset, 'windows-1252'
  end
  
  def test_set_default_charset
    @app = Windows.new
    get '/'
    assert_match 'charset=windows-1252', last_response['Content-Type']
  end
end
