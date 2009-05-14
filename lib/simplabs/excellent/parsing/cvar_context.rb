require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class CvarContext < SexpContext

        def initialize(exp, parent)
          super
          @name = exp[1].to_s.gsub(/@/, '')
        end

        def full_name
          return @name if @parent.blank?
          full_name = @name
          parent = @parent
          parent = parent.parent until parent.is_a?(ClassContext) || parent.is_a?(ModuleContext)
          full_name = "#{parent.full_name}::#{full_name}"
          full_name.reverse.sub(/::/, '.').reverse
        end

      end

    end

  end

end
