module Simpler
  class Controller
    class FileRenderer < Renderer

      def render_body(binding)
        @request.env['simpler.template'] = @options[:template] if @options[:template]
        View.new(@request.env).render(binding)
      end
    end
  end
end