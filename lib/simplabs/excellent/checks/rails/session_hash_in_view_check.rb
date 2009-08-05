require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports views (and partials) that use the +session+ hash directly. Using the +session+ hash directly in views can result in security
        # problems if the value is printed to the output and in general is a bad habit because the controller is circumvented that is responsible
        # for dealing with any session values.
        #
        # ==== Applies to
        #
        # * partials and regular views
        class SessionHashInViewCheck < Base

          def initialize #:nodoc:
            super
            @interesting_nodes = [:call]
            @interesting_files = [/^.*\.(erb|rhtml)$/]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, 'Session hash used in view.') if (context.full_name == 'session')
          end

        end

      end

    end

  end

end
