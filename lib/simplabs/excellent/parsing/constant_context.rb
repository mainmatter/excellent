module Simplabs

  module Excellent

    module Parsing

      class ConstantContext < SexpContext #:nodoc:

        def initialize(exp, parent)
          super
          @name = exp[1]
        end

      end

    end

  end

end
