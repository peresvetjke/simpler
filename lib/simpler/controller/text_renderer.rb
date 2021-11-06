module Simpler
  class Controller
    class TextRenderer < Renderer

      def render_body(binding)
        @response.set_header('Content-Type', 'text/plain; charset=utf-8')
        options[:plain] # NoMethodError (undefined method `html_safe'
      end
    end
  end
end