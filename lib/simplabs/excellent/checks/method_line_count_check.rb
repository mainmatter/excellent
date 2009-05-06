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

          def node_to_count(node)
            node[3][1]
          end

          def error_args(node, line_count)
            ['Method {{method}} has {{count}} lines.', { :method => node[1], :count => line_count }]
          end

      end

    end

  end

end
