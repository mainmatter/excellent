module Simplabs

  module Excellent

    module Parsing

      class CvarContext < SexpContext #:nodoc:

        def initialize(exp, parent)
          super
          @name = exp[1].to_s.sub(/^@+/, '')
        end

        def full_name
          return @name if @parent.blank?
          full_name = @name
          parent = @parent
          parent = parent.parent until parent.is_a?(ClassContext) || parent.is_a?(ModuleContext)
          full_name = "#{parent.full_name}.#{full_name}"
        end

      end

    end

  end

end
