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

        def evaluate(context)
          add_error(context, 'Assignment in condition.') if context.tests_assignment?
        end

      end

    end

  end

end
