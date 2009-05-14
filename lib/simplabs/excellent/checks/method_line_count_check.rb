require 'simplabs/excellent/checks/line_count_check'

module Simplabs

  module Excellent

    module Checks

      class MethodLineCountCheck < LineCountCheck

        DEFAULT_THRESHOLD = 20

        def initialize(options = {})
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:defn], threshold)
        end

        protected

          def error_args(context)
            ['{{method}} has {{count}} lines.', { :method => context.full_name, :count => context.line_count }]
          end

      end

    end

  end

end
