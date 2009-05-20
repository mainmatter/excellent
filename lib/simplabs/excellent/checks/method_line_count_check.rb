require 'simplabs/excellent/checks/line_count_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports methods which have more lines than the threshold. Methods with a large number of lines are hard to read and understand
      # and often an indicator for badly designed code as well.
      #
      # ==== Applies to
      #
      # * methods
      class MethodLineCountCheck < LineCountCheck

        DEFAULT_THRESHOLD = 20

        def initialize(options = {}) #:nodoc:
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:defn], threshold)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, '{{method}} has {{count}} lines.', { :method => context.full_name, :count => context.line_count }]
          end

      end

    end

  end

end
