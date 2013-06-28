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

        def initialize(options = {}) #:nodoc:
          options[:threshold] ||= DEFAULT_THRESHOLD
          super([Parsing::ClassContext], options)
        end

        def evaluate(context)
          line_count = context.line_count == 1 ? 1 : context.line_count + 1
          add_warning(*warning_args(context, line_count)) unless line_count <= @threshold
        end

        protected

          def warning_args(context, line_count) #:nodoc:
            [context, '{{class}} has {{count}} lines.', { :class => context.full_name, :count => line_count }]
          end

      end

    end

  end

end
