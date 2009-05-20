require 'simplabs/excellent/checks/name_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports classes with bad names. Badly named classes make reading and understanding the code much harder. Class names regarded as bad
      # are for example:
      #
      # * names that are not Pascal cased (camel cased, starting with an upper case letter)
      #
      # ==== Applies to
      #
      # * classes
      class ClassNameCheck < NameCheck

        DEFAULT_PATTERN = /^[A-Z]{1}[a-zA-Z0-9]*$/
      
        def initialize(options = {}) #:nodoc:
          pattern = options[:pattern] || DEFAULT_PATTERN
          super([:class], pattern)
        end
      
        protected

          def warning_args(context) #:nodoc:
            [context, 'Bad class name {{class}}.', { :class => context.full_name }]
          end

      end

    end

  end

end
