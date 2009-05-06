require 'simplabs/excellent/checks/line_count_check'

module Simplabs

  module Excellent

    module Checks

      class ClassLineCountCheck < LineCountCheck

        DEFAULT_THRESHOLD = 300

        def initialize(options = {})
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:class], threshold)
        end

        protected

          def node_to_count(node)
            node[3]
          end

          def error_args(node, line_count)
            ['Class {{class}} has {{count}} lines.', { :class => node[1], :count => line_count }]
          end

      end

    end

  end

end
