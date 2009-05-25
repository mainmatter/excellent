module Simplabs

  module Excellent

    module Parsing

      class IvarContext < SexpContext #:nodoc:

        def initialize(exp, parent)
          super
          @name = exp[1].to_s.sub(/^@+/, '')
        end

        def full_name
          return @name if @parent.nil?
          full_name = @name
          parent = @parent
          parent = parent.parent until parent.is_a?(ClassContext) || parent.is_a?(ModuleContext) || parent.nil?
          if parent
            full_name = "#{parent.full_name}.#{full_name}"
          else
            @name
          end
        end

      end

    end

  end

end
