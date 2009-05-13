require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ControlCouplingCheck < Base

        def interesting_nodes
          [:if, :case]
        end

        def evaluate(node, context = nil)
          return unless context
          if tested_parameter = context.tests_parameter?
            add_error('Control of {{method}} is coupled to {{argument}}.', { :method => context.parent.full_name, :argument => tested_parameter }, -1)
          end
        end

      end

    end

  end

end
