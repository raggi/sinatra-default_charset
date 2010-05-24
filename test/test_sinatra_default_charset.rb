require "sinatra/default_charset"

class TestSinatraDefaultCharset < MiniTest::Unit::TestCase
  class TestApp < Sinatra::Base
    register Sinatra::DefaultCharset

    get '/' do
      "hello world\n"
    end
  end
  
  def test_sanity
    flunk "write tests or I will kneecap you"
  end
end
