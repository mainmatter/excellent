require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports methods with bad names. Badly named methods make reading and understanding the code much harder. Method names regarded as bad
      # are for example:
      #
      # * names that are camel cased
      #
      # ==== Applies to
      #
      # * methods
      class MethodNameCheck < NameCheck

        DEFAULT_PATTERN   = /^[_a-z<>=\[|+-\/\*\~\%\&`\|\^]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/
        DEFAULT_WHITELIST = %w([] ! !=  !~ % & * ** + +@ - -@ / < << <= <=> == === =~ > >= >> ^ ` | ~)

        def initialize(options = {}) #:nodoc:
          options[:pattern]   ||= DEFAULT_PATTERN
          options[:whitelist] ||= DEFAULT_WHITELIST
          super([Parsing::MethodContext, Parsing::SingletonMethodContext], options)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, 'Bad method name {{method}}.', { :method => context.full_name }]
          end

      end

    end

  end

end
