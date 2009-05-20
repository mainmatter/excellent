module Simplabs

  module Excellent

    module Parsing

      class WhileContext < SexpContext #:nodoc:

        def initialize(exp, parent)
          super
          @contains_assignment = has_assignment?
        end

        def tests_assignment?
          @contains_assignment
        end

      end

    end

  end

end
