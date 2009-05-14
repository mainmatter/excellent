require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ForLoopCheck < Base

        def interesting_nodes
          [:for]
        end

        def evaluate(context)
          add_error('For loop used.')
        end

      end

    end

  end

end
