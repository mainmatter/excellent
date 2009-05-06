require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class AssignmentInConditionalCheck < Base

        def initialize(options = {})
          super()
        end

        def interesting_nodes
          [:if, :while, :until]
        end

        def evaluate(node)
          add_error('Assignment in condition.') if has_assignment?(node[1])
        end

        private

          def has_assignment?(node)
            found_assignment = false
            found_assignment = found_assignment || node.node_type == :lasgn
            node.children.each { |child| found_assignment = found_assignment || has_assignment?(child) }
            found_assignment
          end

      end

    end

  end

end
