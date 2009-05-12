require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class MethodNameCheck < NameCheck

        DEFAULT_PATTERN = /^[_a-z<>=\[|+-\/\*\~\%\&`\|\^]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/

        def initialize(options = {})
          pattern = options['pattern'] || DEFAULT_PATTERN
          super([:defn], pattern)
        end

        def find_name(node)
          node[1]
        end

        protected

          def error_args(node)
            ['Bad method name {{method}}.', { :method => node[1] }]
          end

      end

    end

  end

end
