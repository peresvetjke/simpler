module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :path

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
      end

      def match?(method, path)
        @method == method && path.match(pattern)
      end

      def params(env)
        request_path = env['PATH_INFO']
        m = pattern.match(request_path)
        values = {}
        route_params.each { |param| values[param.to_sym] = m[param].to_i }
        values
      end

      private

      def route_params
        path.scan(/(?<=:)\w+/)
      end

      def pattern
        p = path.clone
        route_params.each { |param| p.sub!(":#{param}", "(?<#{param}>\\w+)")}
        Regexp.new "^" + p.gsub(/\/?$/, "\/?$")
      end
    end
  end
end
