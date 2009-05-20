require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports +ActiveRecord+ models that do not specify +attr_accessible+. Specifying +attr_accessible+ is viable to protect models from
        # mass assignment attacks (see http://guides.rubyonrails.org/security.html#mass-assignment). +attr_accessible+ specifies a list of properties
        # that are writeable by mass assignments. For a +User+ model for example, that list would possibly include properties like +first_name+ and
        # +last_name+ while it should not include properties like +is_admin+.
        #
        # ==== Applies to
        #
        # * +ActiveRecord+ models
        class AttrAccessibleCheck < Base

          def initialize #:nodoc:
            super
            @interesting_nodes = [:class]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, '{{class}} does not specify attr_accessible.', { :class => context.full_name }) if context.activerecord_model? && !context.specifies_attr_accessible?
          end

        end

      end

    end

  end

end
