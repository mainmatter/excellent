module Simplabs

  module Excellent

    module Parsing

      class SexpContext

        attr_reader :parent
        attr_reader :name

        def initialize(exp, parent = nil)
          @exp    = exp
          @parent = parent
        end

        def full_name
          return @name unless @parent
          "#{@parent.full_name}::#{@name}"
        end

      end

    end

  end

end
