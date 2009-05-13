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
          [:defn, :iter]
        end

        def evaluate(node, context = nil)
          method_name = node.node_type == :defn ? node[1] : node[1][2]
          parameter_count = count_parameters(node)
          unless parameter_count <= @threshold
            add_error('{{method}} has {{parameter_count}} parameters.', { :method => method_name, :parameter_count => parameter_count })
          end
        end

        private

          def count_parameters(node)
            if node.node_type == :defn
              node[2][1..-1].inject(0) { |count, each| count = count + (each.class == Symbol ? 1 : 0) }
            else
              node[2][1].length - 1
            end
          end

      end

    end

  end

end
