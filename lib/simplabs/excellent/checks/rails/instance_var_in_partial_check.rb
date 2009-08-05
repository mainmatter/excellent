require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports partials that use instance variables. Using instance variables in partials couples the partial to the controller action or
        # template that includes the partial and that has to define the instance variable.
        #
        # ==== Applies to
        #
        # * partials
        class InstanceVarInPartialCheck < Base

          def initialize #:nodoc:
            super
            @interesting_nodes = [:ivar]
            @interesting_files = [/^_.*\.erb$/]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, 'Instance variable {{variable}} used in partial.', { :variable => context.full_name })
          end

        end

      end

    end

  end

end
