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

        def evaluate(node, context = nil)
          name = find_name(node)
          add_error(*error_args(node)) unless name.to_s =~ @pattern
        end

      end

    end

  end

end
