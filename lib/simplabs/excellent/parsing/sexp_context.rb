module Simplabs

  module Excellent

    module Parsing

      class SexpContext

        attr_reader :parent
        attr_reader :name
        attr_reader :line_count
        attr_reader :file
        attr_reader :line

        def initialize(exp, parent = nil)
          @exp        = exp
          @parent     = parent
          @line_count = count_lines
          @file       = exp.file
          @line       = exp.line
          @full_name  = nil
        end

        def full_name
          return @full_name if @full_name
          return @name if @parent.blank?
          "#{@parent.full_name}::#{@name}"
        end

        def line_offset
          @parent ? @parent.line_offset : 0
        end

        private

          def count_lines(node = @exp, line_numbers = [])
            count = 0
            line_numbers << node.line
            node.children.each { |child| count += count_lines(child, line_numbers) }
            line_numbers.uniq.length
          end

      end

    end

  end

end
