module Simpler
  class Controller
    class InlineRenderer < Renderer

      def render_body(binding)
        @request.env['simpler.inline_body'] = options[:inline]
        View.new(@request.env).render(binding)
      end
    end
  end
end