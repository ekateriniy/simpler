require 'erb'

module Simpler
  class View

    VIEW_BASE_PATH = 'app/views'.freeze

    def initialize(env)
      @env = env
    end

    def render(binding)
      send("render_#{format}", binding)
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

    def format
      @env['simpler.format'] || 'html'
    end

    def template_path
      path = template || [controller.name, action].join('/')
      @env['simpler.template_path'] = "#{path}.html.erb"
    
      Simpler.root.join(VIEW_BASE_PATH, "#{path}.html.erb")
    end

    def render_plain(_binding)
      template.to_s
    end

    def render_html(binding)
      template = File.read(template_path)
      ERB.new(template).result(binding)
    end
  end
end
