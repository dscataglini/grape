module Grape
  module Middleware
    class Base
      attr_reader :app, :env, :options
      
      def initialize(app, options = {})
        @app = app
        @options = default_options.merge(options)
      end
      
      def default_options; {} end
      
      def call(env)
        dup.call!(env)
      end
      
      def call!(env)
        @env = env
        before
        @app_response = @app.call(@env)
        after || @app_response
      end
      
      def before; end
      def after; end
      
      def request
        Rack::Request.new(self.env)
      end
      
      def response
        Rack::Response.new(@app_response)
      end
    end
  end
end