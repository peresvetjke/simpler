module Simpler
  class Controller
    class Renderer
      
      attr_reader   :options
      attr_accessor :request, :response
      
      def self.determine_renderer(options)
        if options&.key?(:plain)
          TextRenderer
        elsif options&.key?(:inline)
          InlineRenderer
        else
          FileRenderer
        end
      end

      def initialize(request, response, options)
        @request = request
        @response = response
        @options = options || {}
      end
    end
  end
end