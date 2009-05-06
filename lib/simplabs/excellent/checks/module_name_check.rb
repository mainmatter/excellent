require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ModuleNameCheck < NameCheck

        DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/

        def initialize(options = {})
          pattern = options['pattern'] || DEFAULT_PATTERN
          super([:module], pattern)
        end

        def find_name(node)
          node[1].class == Symbol ? node[1] : node[1].last
        end

        protected

          def error_args(node)
            ['Bad module name {{module}}.', { :module => node[1] }]
          end

      end

    end

  end

end
