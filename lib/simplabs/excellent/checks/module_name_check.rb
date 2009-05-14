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

        protected

          def error_args(context)
            ['Bad module name {{module}}.', { :module => context.full_name }]
          end

      end

    end

  end

end
