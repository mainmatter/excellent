require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class ClassContext < SexpContext

        #TODO: cleanup!

        attr_reader :methods
        attr_reader :line_count
        attr_reader :base_class_name

        def initialize(exp, parent)
          super
          if @exp[1].is_a?(Sexp)
            @name = @exp[1].pop.to_s.strip
            @full_name = "#{extract_prefixes}#{@name}"
          else
            @name = exp[1].to_s
          end
          @methods = []
          @line_count = count_lines
          @base_class_name = ''
          base = exp[2]
          while base.is_a?(Sexp)
            @base_class_name = "#{base.last}::#{@base_class_name}"
            if base[0] == :colon2
              base = base[1]
            elsif base[0] == :const
              base = false
            else
              break
            end
          end
          @base_class_name = @base_class_name.empty? ? nil : @base_class_name.sub(/::$/, '')
          @attr_accessible = false
          @attr_protected = false
        end

        def activerecord_model?
          @base_class_name == 'ActiveRecord::Base'
        end

        def process_call(exp)
          @attr_accessible = true if exp[2] == :attr_accessible
          @attr_protected = true if exp[2] == :attr_protected
        end

        def specifies_attr_accessible?
          @attr_accessible
        end

        def specifies_attr_protected?
          @attr_protected
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
