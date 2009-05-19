require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class FlogCheck < Base

        def initialize(interesting_nodes, threshold)
          super()
          @interesting_nodes = interesting_nodes
          @threshold         = threshold
        end

        def interesting_nodes
          @interesting_nodes
        end

        def evaluate(context)
          add_error(*error_args(context)) unless context.flog_score <= @threshold
        end

      end

    end

  end

end
