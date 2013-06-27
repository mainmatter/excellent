require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports global variables. Global variables introduce strong dependencies between otherwise unrelated parts of code and their use is
      # usually considered extremely bad style.
      #
      # ==== Applies to
      #
      # * global variables
      class GlobalVariableCheck < Base

        def initialize #:nodoc:
          super
          @interesting_contexts = [Parsing::GvarContext, Parsing::GasgnContext]
          @interesting_files    = [/\.rb$/, /\.erb$/]
        end

        def evaluate(context) #:nodoc:
          if context.is_a?(Parsing::GasgnContext) || !context.reassigned_local_exception_var?
            add_warning(context, 'Global variable {{variable}} used.', { :variable => context.full_name })
          end
        end

      end

    end

  end

end
