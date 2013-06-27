module Simplabs

  module Excellent

    module Parsing

      class GvarContext < SexpContext #:nodoc:

        def initialize(exp, parent)
          super
          @name      = exp[1].to_s.sub(/^\$/, '')
          @full_name = @name
        end

        def reassigned_local_exception_var?
          if self.parent.is_a?(Simplabs::Excellent::Parsing::ResbodyContext)
            @name == '!' && self.parent.assigns_exception_to_local_variable?.inspect
          else
            false
          end
        end

      end

    end

  end

end
