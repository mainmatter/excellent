require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class NestedIteratorsCheck < Base

        def interesting_nodes
          [:iter]
        end

        def evaluate(context)
          add_error('{{block}} inside of {{parent}}.', { :block => context.full_name, :parent => context.parent.full_name }) if context.inside_block?
        end

      end

    end

  end

end
