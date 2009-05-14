require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class ModuleContext < SexpContext

        attr_reader :methods

        def initialize(exp, parent)
          super
          if @exp[1].is_a?(Sexp)
            @name = @exp[1].pop.to_s.strip
            @full_name = "#{extract_prefixes}#{@name}"
          else
            @name = exp[1].to_s
          end
          @methods = []
        end

        private

          def extract_prefixes(exp = @exp[1], prefix = '')
            prefix = "#{exp.pop}::#{prefix}" if exp.last.is_a?(Symbol)
            if exp.last.is_a?(Sexp)
              prefix = extract_prefixes(exp.last, prefix)
            end
            prefix
          end

      end

    end

  end

end
