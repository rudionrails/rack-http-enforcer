module Rack
  class HttpEnforcer
    
    def initialize( app, options = {} )
      @app, @options = app, options
    end
    
    def call( env )      
      scheme = 'http' unless http_request?( env )
      
      if scheme
        location = redirect_to || request_url( env, scheme )
        body = "<html><body>You are being <a href=\"#{location}\">redirected</a>.</body></html>"
        
        [ 301, { 'Content-Type' => 'text/html', 'Location' => location }, [body] ]
      else
        @app.call( env )
      end
    end
    
    
  private
    
    def http_request?( env )
      scheme( env ) == 'http'
    end
    
    # Fixed in rack >= 1.3
    def scheme( env )
      if env['HTTPS'] == 'on'
        'https'
      elsif env['HTTP_X_FORWARDED_PROTO']
        env['HTTP_X_FORWARDED_PROTO'].split(',')[0]
      else
        env['rack.url_scheme']
      end
    end
    
    def request_url( env, scheme )
      Rack::Request.new( env.merge('rack.url_scheme' => scheme) ).url
    end
    
    def redirect_to
      if @options[:redirect_to].is_a?( Proc )
        @options[:redirect_to].call
      else
        @options[:redirect_to]
      end
    end
    
  end
end
