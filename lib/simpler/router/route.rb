module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && parsed_path(path)
      end

      private

      def parsed_path(path)
        route_path = parse_path(@path)
        requested_path = parse_path(path)
        if route_path.size == requested_path.size
          route_path.each_with_index do |param, id|
            @params[param[1..-1].to_sym] = requested_path[id] if id?(param)
          end
        else
          false
        end
      end

      def parse_path(path)
        path.split('/').delete_if { |part| part.empty? }
      end

      def id?(id)
        id[0] == ':'
      end
    end
  end
end
