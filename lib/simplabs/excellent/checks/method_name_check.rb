require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class MethodNameCheck < NameCheck

        DEFAULT_PATTERN = /^[_a-z<>=\[|+-\/\*\~\%\&`\|\^]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/

        def initialize(options = {})
          pattern = options['pattern'] || DEFAULT_PATTERN
          super([:defn, :defs], pattern)
        end

        protected

          def error_args(context)
            [context, 'Bad method name {{method}}.', { :method => context.full_name }]
          end

      end

    end

  end

end
