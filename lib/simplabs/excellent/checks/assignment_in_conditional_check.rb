require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports conditionals that test an assignment as in
      #
      #  something(var) if var = method()
      #
      # Assignments in conditions are often typos.
      #
      # ==== Applies to
      #
      # * +if+
      # * +else+
      # * +while+
      # * +until+
      class AssignmentInConditionalCheck < Base

        def initialize(options = {}) #:nodoc:
          super
          @interesting_contexts = [Parsing::IfContext, Parsing::WhileContext, Parsing::UntilContext]
          @interesting_files    = [/\.rb$/, /\.erb$/]
        end

        def evaluate(context) #:nodoc:
          add_warning(context, 'Assignment in condition.') if context.tests_assignment?
        end

      end

    end

  end

end
