require 'simplabs/excellent/checks/name_check'

module Simplabs

  module Excellent

    module Checks

      # Checks a class name to make sure it matches the specified pattern.
      # 
      # Keeping to a consistent naming convention makes your code easier to read.
      class ClassNameCheck < NameCheck

        DEFAULT_PATTERN = /^[A-Z]{1}[a-zA-Z0-9]*$/
      
        def initialize(options = {})
          pattern = options[:pattern] || DEFAULT_PATTERN
          super([:class], pattern)
        end
      
        protected

          def error_args(context)
            ['Bad class name {{class}}.', { :class => context.full_name }]
          end

      end

    end

  end

end
