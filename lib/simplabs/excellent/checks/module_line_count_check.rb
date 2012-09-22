require 'simplabs/excellent/checks/line_count_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports modules which have more lines than the threshold. Modules with a large number of lines are hard to read and understand
      # and often an indicator for badly designed code as well.
      #
      # ==== Applies to
      #
      # * modules
      class ModuleLineCountCheck < LineCountCheck

        DEFAULT_THRESHOLD = 300

        def initialize(options = {}) #:nodoc:
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([Parsing::ModuleContext], threshold)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, '{{module}} has {{count}} lines.', { :module => context.full_name, :count => context.line_count }]
          end

      end

    end

  end

end
