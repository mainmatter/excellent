require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports views (and partials) that access the +session+ hash. Accessing the +session+ hash directly in views can result in security
        # problems if the value is printed to the HTML output and in general is a bad habit because the controller, which is actually the part of the
        # application that is responsible for dealing with session data, is circumvented.
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
