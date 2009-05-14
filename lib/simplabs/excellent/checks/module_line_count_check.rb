require 'simplabs/excellent/checks/line_count_check'

module Simplabs

  module Excellent

    module Checks

      class ModuleLineCountCheck < LineCountCheck

        DEFAULT_THRESHOLD = 300

        def initialize(options = {})
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:module], threshold)
        end

        protected

          def error_args(context)
            ['{{module}} has {{count}} lines.', { :module => context.full_name, :count => context.line_count }]
          end

      end

    end

  end

end
