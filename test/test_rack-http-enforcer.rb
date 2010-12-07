require File.dirname(__FILE__) + '/helper'

class TestRackHttpEnforcer < Test::Unit::TestCase

  context 'on GET to http' do
    setup { mock_app }
    
    should 'not respond with a http redirect' do
      get 'http://www.example.org/'
      
      assert_equal 200, last_response.status
      assert_nil last_response.location
      assert_equal 'Hello world!', last_response.body
    end
    
    should 'not respect X-Forwarded-Proto header for proxied requests' do
      get 'http://www.example.org/', {}, { 'HTTP_X_FORWARDED_PROTO' => 'http', 'rack.url_scheme' => 'https' }
      
      assert_equal 200, last_response.status
      assert_nil last_response.location
      assert_equal 'Hello world!', last_response.body
    end
  end
  
  context 'on GET to https to plain-text requests' do
  
    context 'without :redirect_to defined' do
      setup { mock_app }
      
      should 'respond with a http redirect' do
        get 'https://www.example.org/'
        
        assert_equal 301, last_response.status
        assert_equal 'http://www.example.org/', last_response.location
      end
      
      should 'respond with a http redirect and keep params' do
        get 'https://www.example.org/admin?token=33'
        
        assert_equal 301, last_response.status
        assert_equal 'http://www.example.org/admin?token=33', last_response.location
      end
      
      should 'respect X-Forwarded-Proto header for proxied requests' do
        get 'http://www.example.org/', {}, { 'HTTP_X_FORWARDED_PROTO' => 'https', 'rack.url_scheme' => 'http' }
        
        assert_equal 301, last_response.status
        assert_equal 'http://www.example.org/', last_response.location
      end
      
      should 'use default http port when redirecting from non-standard port' do
        get 'https://example.org:81/'
        
        assert_equal 301, last_response.status
        assert_equal 'http://example.org/', last_response.location
      end
    end
    
    context 'with :redirect_to defined' do
      setup { mock_app :redirect_to => 'http://www.redirect.com' }
      
      should 'respond with a http redirect and redirect to :redirect_to' do
        get 'https://www.example.org/'
        
        assert_equal 301, last_response.status
        assert_equal 'http://www.redirect.com', last_response.location
      end
    end
  end
  
end
