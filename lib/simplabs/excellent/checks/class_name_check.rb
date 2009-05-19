require 'simplabs/excellent/checks/name_check'

module Simplabs

  module Excellent

    module Checks

      class ClassNameCheck < NameCheck

        DEFAULT_PATTERN = /^[A-Z]{1}[a-zA-Z0-9]*$/
      
        def initialize(options = {})
          pattern = options[:pattern] || DEFAULT_PATTERN
          super([:class], pattern)
        end
      
        protected

          def error_args(context)
            [context, 'Bad class name {{class}}.', { :class => context.full_name }]
          end

      end

    end

  end

end
