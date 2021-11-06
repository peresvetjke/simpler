require_relative 'view'
require_relative 'controller/renderer'
require_relative 'controller/inline_renderer'
require_relative 'controller/text_renderer'
require_relative 'controller/file_renderer'

module Simpler
  class Controller

    DEFAULT_HEADERS = {'Content-Type' => 'text/html; charset=utf-8'}.freeze

    attr_reader :name, :request, :response
    attr_accessor :renderer, :options

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @renderer = nil
      @options = nil
    end

    def make_response(action, params)
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

    def write_response
      body = render_body
      @response.write(body)
    end

    def render_body
      renderer = Renderer.determine_renderer(options)
      renderer.new(@request, @response, options).render_body(binding)
    end

    def set_default_headers
      DEFAULT_HEADERS.each { |k,v| set_header(k, v) }
    end

    def set_params(params)
      params.each { |k, v| @request.update_param(k, v) }
      @request.env['simpler.params'] = "#{params}"
    end

    def params
      @request.params
    end

    def render(**args)
      @response.status = args[:status] if args.key?(:status)
      @options = args
    end

    def set_header(key, v)
      @response.set_header(key, v)
    end
  end
end
