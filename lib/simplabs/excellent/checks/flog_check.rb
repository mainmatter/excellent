require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class FlogCheck < Base #:nodoc:

        def initialize(interesting_contexts, options = {}) #:nodoc:
          super(options)
          @interesting_contexts = interesting_contexts
          @threshold            = options[:threshold].to_i
        end

        def evaluate(context)
          add_warning(*warning_args(context)) unless context.flog_score <= @threshold
        end

      end

    end

  end

end
