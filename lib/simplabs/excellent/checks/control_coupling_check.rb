require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports methods that check the value of a parameter to decide which execution path to take. Control Coupling introduces a
      # dependency between the caller and the callee. Any changes to the possible values of the parameter must be reflected at the caller side
      # as well as at the called method.
      #
      # ==== Applies to
      #
      # * methods
      class ControlCouplingCheck < Base

        def initialize(options = {}) #:nodoc:
          super
          @interesting_contexts = [Parsing::IfContext, Parsing::CaseContext]
        end

        def evaluate(context) #:nodoc:
          if tested_parameter = context.tests_parameter?
            add_warning(context, '{{method}} is coupled to {{argument}}.', { :method => context.parent.full_name, :argument => tested_parameter.to_s })
          end
        end

      end

    end

  end

end
