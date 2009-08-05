module Simplabs

  module Excellent

    module Parsing

      class GvarContext < SexpContext #:nodoc:

        def initialize(exp, parent)
          super
          @name      = exp[1].to_s.sub(/^\$/, '')
          @full_name = @name
        end

      end

    end

  end

end
