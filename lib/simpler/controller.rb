require_relative 'view'

module Simpler
  class Controller

    DEFAULT_HEADERS = {'Content-Type' => 'text/html; charset=utf-8'}.freeze

    attr_reader :name, :request, :response

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      @request.env['simpler.handler'] = "#{self.class}##{action}"

      set_params(params)
      set_default_headers
      send(action)
      write_response

      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      DEFAULT_HEADERS.each { |k, v| set_header(k,v) }
    end

    def write_response(body = nil)
      body ||= render_body

      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def set_params(params)
      params.each { |k, v| @request.update_param(k, v) }
      @request.env['simpler.params'] = "#{params}"
    end

    def params
      @request.params
    end

    def render(**args)
      args.each { |k, v| send("render_#{k}", v) }
    end

    def render_template(template)
      @request.env['simpler.template'] = template
    end

    def render_status(status)
      @response.status = status
    end

    def render_plain(body)
      write_response(body)
      set_header('Content-Type', 'text/plain; charset=utf-8')
    end

    def render_inline(body)
      @request.env['simpler.inline_body'] = body
    end

    def set_header(key, v)
      @response[key] = v
    end
  end
end
