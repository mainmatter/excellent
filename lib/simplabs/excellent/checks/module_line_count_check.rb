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

          def node_to_count(node)
            node[2]
          end

          def error_args(node, line_count)
            ['Module {{module}} has {{count}} lines.', { :module => node[1], :count => line_count }]
          end

      end

    end

  end

end
