require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        class AttrAccessibleCheck < Base

          def interesting_nodes
            [:class]
          end

          def evaluate(context)
            add_error(context, '{{class}} does not specify attr_accessible.', { :class => context.full_name }) if context.activerecord_model? && !context.specifies_attr_accessible?
          end

        end

      end

    end

  end

end
