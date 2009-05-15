require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        class AttrProtectedCheck < Base

          def interesting_nodes
            [:class]
          end

          def evaluate(context)
            add_error('{{class}} specifies attr_protected.', { :class => context.full_name }) if context.activerecord_model? && context.specifies_attr_protected?
          end

        end

      end

    end

  end

end
