module Simplabs

  module Excellent

    module Parsing

      module CyclomaticComplexityMeasure

        COMPLEXITY_NODE_TYPES = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]

        private

          def count_cyclomytic_complexity(exp = @exp)
            count = 0
            count = count + 1 if COMPLEXITY_NODE_TYPES.include?(exp.node_type)
            exp.children.each { |child| count += count_cyclomytic_complexity(child) }
            count
          end

      end

    end

  end

end
