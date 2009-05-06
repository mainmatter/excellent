require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityCheck < Base

        COMPLEXITY_NODE_TYPES = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]

        def initialize(threshold)
          super()
          @threshold = threshold
        end

        protected

          def count_complexity(node)
            count_branches(node) + 1
          end

        private

          def count_branches(node)
            count = 0
            count = count + 1 if COMPLEXITY_NODE_TYPES.include? node.node_type
            node.children.each { |child| count += count_branches(child) }
            count
          end

      end

    end

  end

end
