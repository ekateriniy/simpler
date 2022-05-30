require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    response = @app.call(env)
    @logger.info(message(response, env))

    response
  end

  def message(response, env)
    "\nRequest: #{env['REQUEST_METHOD']} #{env['REQUEST_PATH']}\n"\
    "Handler: #{env['simpler.controller'].class}##{env['simpler.action']}\n" \
    "Parameters: #{env['simpler.params']}\n" \
    "Response: #{response[0]} #{response[1]['Content-Type']} #{env['simpler.template_path']}\n"
  end
end
