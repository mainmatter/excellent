require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports views (and partials) that use the +params+ hash directly. Using the +params+ hash directly in views can result in security
        # problems if the value is printed to the output and in general is a bad habit because the controller is circumvented that is responsible
        # for dealing with any parameters.
        #
        # ==== Applies to
        #
        # * partials and regular views
        class ParamsHashInViewCheck < Base

          def initialize #:nodoc:
            super
            @interesting_nodes = [:call]
            @interesting_files = [/^.*\.(erb|rhtml)$/]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, 'Params hash used in view.') if (context.full_name == 'params')
          end

        end

      end

    end

  end

end
