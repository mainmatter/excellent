require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class LineCountCheck < Base

        def initialize(interesting_nodes, threshold)
          super()
          @interesting_nodes = interesting_nodes
          @threshold         = threshold
        end

        def interesting_nodes
          @interesting_nodes
        end

        def evaluate(node, context = nil)
          line_count = count_lines(node_to_count(node)) - 1
          add_error(*error_args(node, line_count)) unless line_count <= @threshold
        end

        protected
  
          def node_to_count(node)
            node
          end
  
          def count_lines(node, line_numbers = [])
            count = 0
            line_numbers << node.line
            node.children.each { |child| count += count_lines(child, line_numbers) }
            line_numbers.uniq.length
          end

      end

    end

  end

end
