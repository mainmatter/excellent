require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports nested iterators. Nested iterators lead to introduce performance issues.
      #
      # ==== Applies to
      #
      # * blocks
      class NestedIteratorsCheck < Base

        def initialize #:nodoc:
          super
          @interesting_nodes = [:iter]
        end

        def evaluate(context) #:nodoc:
          if context.inside_block?
            add_warning(context, '{{block}} inside of {{parent}}.', { :block => context.full_name, :parent => context.parent.full_name })
          end
        end

      end

    end

  end

end
