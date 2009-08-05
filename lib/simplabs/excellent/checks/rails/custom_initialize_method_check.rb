require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports +ActiveRecord+ models that define custom +initialize+ methods. Since +ActiveRecord+ does not always call usw +new+ to
        # create instances, these custom +initialize+ methods might not always be called.
        #
        # ==== Applies to
        #
        # * +ActiveRecord+ models
        class CustomInitializeMethodCheck < Base

          def initialize #:nodoc:
            super
            @interesting_nodes = [:class]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, '{{class}} defines initialize method.', { :class => context.full_name }) if context.active_record_model? && !context.defines_initializer?
          end

        end

      end

    end

  end

end
