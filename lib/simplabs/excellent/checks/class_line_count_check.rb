require 'simplabs/excellent/checks/line_count_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports classes which have more lines than the threshold. Classes with a large number of lines are hard to read and understand and
      # often an indicator for badly designed code as well.
      #
      # ==== Applies to
      #
      # * classes
      class ClassLineCountCheck < LineCountCheck

        DEFAULT_THRESHOLD = 400

        def initialize(options = {}) #:nodoc:
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:class], threshold)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, '{{class}} has {{count}} lines.', { :class => context.full_name, :count => context.line_count }]
          end

      end

    end

  end

end
