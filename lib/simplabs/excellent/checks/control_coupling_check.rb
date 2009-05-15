require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ControlCouplingCheck < Base

        def interesting_nodes
          [:if, :case]
        end

        def evaluate(context)
          if tested_parameter = context.tests_parameter?
            add_error('{{method}} is coupled to {{argument}}.', { :method => context.parent.full_name, :argument => tested_parameter.to_s }, -2)
          end
        end

      end

    end

  end

end
