require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class NameCheck < Base

        def initialize(interesting_nodes, pattern)
          super()
          @interesting_nodes = interesting_nodes
          @pattern           = pattern
        end

        def interesting_nodes
          @interesting_nodes
        end

        def evaluate(context)
          add_error(*error_args(context)) unless context.name.to_s =~ @pattern
        end

      end

    end

  end

end
