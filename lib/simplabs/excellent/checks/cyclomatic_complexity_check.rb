require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityCheck < Base #:nodoc:

        def initialize(interesting_contexts, threshold)
          super()
          @interesting_contexts = interesting_contexts
          @threshold            = threshold
        end

      end

    end

  end

end
