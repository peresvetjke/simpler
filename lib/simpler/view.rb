require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      body = @env['simpler.inline_body'] || File.read(template_path)

      ERB.new(body).result(binding)
    end

    private

    def controller
      @env['simpler.controller']
    end

    def action
      @env['simpler.action']
    end

    def template
      @env['simpler.template']
    end

    def template_path
      path = template || [controller.name, action].join('/')

      full_path = "#{path}.html.erb"
      @env['simpler.view'] = full_path
      
      Simpler.root.join(VIEW_BASE_PATH, full_path)
    end

  end
end
