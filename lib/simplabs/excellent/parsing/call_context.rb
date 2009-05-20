module Simplabs

  module Excellent

    module Parsing

      class CallContext < SexpContext #:nodoc:

        include Comparable

        attr_reader :receiver
        attr_reader :method

        def initialize(exp, parent)
          super
          @receiver  = exp[1].is_a?(Sexp) ? (exp[1][1].nil? ? exp[1][2].to_s : exp[1][1].to_s) : nil
          @method    = exp[2].to_s
          @full_name = [@receiver, @method].compact.join('.')
        end

        def <=>(other)
          @full_name <=> other.full_name
        end
        alias :eql? :'<=>'

        def hash
          @full_name.hash
        end

      end

    end

  end

end
