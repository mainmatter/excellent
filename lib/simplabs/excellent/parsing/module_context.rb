require 'simplabs/excellent/parsing/scopeable'

module Simplabs

  module Excellent

    module Parsing

      class ModuleContext < SexpContext

        include Scopeable

        attr_reader :methods
        attr_reader :line_count

        def initialize(exp, parent)
          super
          @name, @full_name = get_names
          @methods = []
          @line_count = count_lines
        end

      end

    end

  end

end
