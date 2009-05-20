require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports modules with bad names. Badly named modules make reading and understanding the code much harder. Module names regarded as bad
      # are for example:
      #
      # * names that are not Pascal cased (camel cased, starting with an upper case letter)
      #
      # ==== Applies to
      #
      # * modules
      class ModuleNameCheck < NameCheck

        DEFAULT_PATTERN = /^[A-Z][a-zA-Z0-9]*$/

        def initialize(options = {}) #:nodoc:
          pattern = options['pattern'] || DEFAULT_PATTERN
          super([:module], pattern)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, 'Bad module name {{module}}.', { :module => context.full_name }]
          end

      end

    end

  end

end
