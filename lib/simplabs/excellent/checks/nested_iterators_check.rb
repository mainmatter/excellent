require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class NestedIteratorsCheck < Base

        def interesting_nodes
          [:iter]
        end

        def evaluate(context)
          if context.inside_block?
            add_error(context, '{{block}} inside of {{parent}}.', { :block => context.full_name, :parent => context.parent.full_name })
          end
        end

      end

    end

  end

end
