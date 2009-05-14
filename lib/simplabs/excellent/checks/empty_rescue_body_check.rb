require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class EmptyRescueBodyCheck < Base

        def interesting_nodes
          [:resbody]
        end

        def evaluate(context)
          add_error('Rescue block is empty.', {}, -1) unless context.has_statements?
        end

      end

    end

  end

end
