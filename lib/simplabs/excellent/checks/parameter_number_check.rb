require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ParameterNumberCheck < Base

        DEFAULT_THRESHOLD = 3

        def initialize(options = {})
          super()
          @threshold = options[:threshold] || DEFAULT_THRESHOLD
        end

        def interesting_nodes
          [:defn]
        end

        def evaluate(node)
          method_name = node[1]
          parameters = node[2][1..-1]
          parameter_count = parameters.inject(0) { |count, each| count = count + (each.class == Symbol ? 1 : 0) }
          unless parameter_count <= @threshold
            add_error('Method {{method}} has {{parameter_count}} parameters.', { :method => method_name, :parameter_count => parameter_count })
          end
        end

      end

    end

  end

end
