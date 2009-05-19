module Simplabs

  module Excellent

    module Parsing

      class SexpContext

        attr_reader :parent
        attr_reader :name
        attr_reader :file
        attr_reader :line

        def initialize(exp, parent = nil)
          @exp        = exp
          @parent     = parent
          @file       = exp.file
          @line       = exp.line
          @full_name  = nil
        end

        def full_name
          return @full_name if @full_name
          return @name if @parent.blank?
          "#{@parent.full_name}::#{@name}"
        end

        def method_missing(method, *args)
          return if method.to_s =~ /^process_[a-zA-Z0-9_]+$/
          super
        end

        private

          def count_lines(node = @exp, line_numbers = [])
            count = 0
            line_numbers << node.line
            node.children.each { |child| count += count_lines(child, line_numbers) }
            line_numbers.uniq.length
          end

          def has_assignment?(exp = @exp[1])
            found_assignment = false
            found_assignment = found_assignment || exp.node_type == :lasgn
            exp.children.each { |child| found_assignment = found_assignment || has_assignment?(child) }
            found_assignment
          end

      end

    end

  end

end
