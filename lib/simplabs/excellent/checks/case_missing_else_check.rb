require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class CaseMissingElseCheck < Base

        def interesting_nodes
          [:case]
        end
  
        def evaluate(context)
          add_error(context, 'Case statement is missing else clause.') unless context.has_else_clause?
        end

      end

    end

  end

end
