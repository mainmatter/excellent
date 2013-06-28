require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports views (and partials) that access the +params+ hash. Accessing the +params+ hash directly in views can result in security
        # problems if the value is printed to the HTML output and in general is a bad habit because the controller, which is actually the part of the
        # application that is responsible for dealing with parameters, is circumvented.
        #
        # ==== Applies to
        #
        # * partials and regular views
        class ParamsHashInViewCheck < Base

          def initialize(options = {}) #:nodoc:
            super
            @interesting_contexts = [Parsing::CallContext]
            @interesting_files    = [/^.*\.(erb|rhtml)$/]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, 'Params hash used in view.', {}, RUBY_VERSION =~ /1\.8/ ? 0 : -1) if (context.full_name == 'params')
          end

        end

      end

    end

  end

end
