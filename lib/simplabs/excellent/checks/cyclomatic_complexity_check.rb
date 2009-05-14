require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityCheck < Base

        def initialize(threshold)
          super()
          @threshold = threshold
        end

      end

    end

  end

end
