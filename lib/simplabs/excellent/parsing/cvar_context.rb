module Simplabs

  module Excellent

    module Parsing

      class CvarContext < SexpContext #:nodoc:

        def initialize(exp, parent)
          super
          @name = exp[1].to_s.sub(/^@+/, '')
        end

        def full_name
          return @name if !@parent
          full_name = @name
          parent    = @parent
          parent = parent.parent until parent.is_a?(ClassContext) || parent.is_a?(ModuleContext) rescue nil
          if !!parent
            "#{parent.full_name}.#{full_name}"
          else
            full_name
          end
        end

      end

    end

  end

end
