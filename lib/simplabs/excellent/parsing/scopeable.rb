module Simplabs

  module Excellent

    module Parsing

      module Scopeable

        private

          def get_names
            if @exp[1].is_a?(Sexp)
              name = @exp[1].pop.to_s.strip
              [name, "#{extract_prefixes}#{name}"]
            else
              [@exp[1].to_s, nil]
            end
          end

          def extract_prefixes(exp = @exp[1].deep_clone, prefix = '')
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
