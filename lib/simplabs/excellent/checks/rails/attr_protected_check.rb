require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports +ActiveRecord+ models that specify +attr_protected+. Like +attr_accessible+, +attr_protected+ is a helper to secure
        # +ActiveRecord+ models against mass assignment attacks (see http://guides.rubyonrails.org/security.html#mass-assignment), but instead of
        # specifying a white list of properties that are writeable by mass assignments as +attr_accessible+ does, +attr_protected+ specifies a black
        # list. Such a black list approach is usually less secure since the list has to be updated for every new property that is introduced, which
        # is easy to forget.
        #
        # ==== Applies to
        #
        # * +ActiveRecord+ models
        class AttrProtectedCheck < Base

          def initialize #:nodoc:
            super
            @interesting_nodes = [:class]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, '{{class}} specifies attr_protected.', { :class => context.full_name }) if context.activerecord_model? && context.specifies_attr_protected?
          end

        end

      end

    end

  end

end
