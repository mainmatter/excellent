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
      
        def find_name(node)
          node[1].class == Symbol ? node[1] : node[1].last
        end

        protected

          def error_args(node)
            ['Bad class name {{class}}.', { :class => node[1] }]
          end

      end

    end

  end

end
