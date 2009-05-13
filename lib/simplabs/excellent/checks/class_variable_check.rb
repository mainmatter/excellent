require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ClassVariableCheck < Base

        def interesting_nodes
          [:cvar]
        end

        def evaluate(node, context = nil)
          add_error('Class variable {{variable}}.', { :variable => node.value }, -1)
        end

      end

    end

  end

end
