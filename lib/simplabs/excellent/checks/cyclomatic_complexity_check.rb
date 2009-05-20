require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityCheck < Base #:nodoc:

        def initialize(interesting_nodes, threshold)
          super()
          @interesting_nodes = interesting_nodes
          @threshold         = threshold
        end

      end

    end

  end

end
