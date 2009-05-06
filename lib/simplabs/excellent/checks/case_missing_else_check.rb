require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class CaseMissingElseCheck < Base

        def interesting_nodes
          [:case]
        end
  
        def evaluate(node)
          add_error('Case statement is missing else clause.') unless node.last
        end

      end

    end

  end

end
