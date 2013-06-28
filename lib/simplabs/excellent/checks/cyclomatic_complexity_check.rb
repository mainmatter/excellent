require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityCheck < Base #:nodoc:

        def initialize(interesting_contexts, options = {}) #:nodoc:
          super(options)
          @interesting_contexts = interesting_contexts
          @threshold            = options[:threshold].to_i
        end

      end

    end

  end

end
