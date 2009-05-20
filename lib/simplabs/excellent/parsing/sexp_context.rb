module Simplabs

  module Excellent

    module Parsing

      # For most nodes the Excellent processor processes, it will create the corresponding context that contains meta information of the processed
      # node. This is the base class for all these contexts.
      #
      # === Example
      #
      # For a method like the following:
      #
      #  module Shop
      #    class Basket
      #      def buy_product(product)
      #        other_method
      #      end
      #    end
      #  end
      #
      # four context will be generated:
      #
      #  ModuleContext
      #    name:      'Shop'
      #    full_name: 'Shop'
      #    parent:    nil
      #  ClassContext
      #    name:      'Basket'
      #    full_name: 'Shop::Basket'
      #    parent:    ModuleContext
      #  MethodContext
      #    name:       'buy_product'
      #    full_name:  'Shop::Basket#buy_product'
      #    parent:     ClassContext
      #    parameters: [:product]
      #  CallContext (other_method)
      #    name:      nil
      #    full_name: nil
      #    parent:    MethodContext
      #    method:    :other_method
      #
      # === Custom Processors
      #
      # The Excelent processor will also invoke custom processor methods on the contexts if they are defined. To process call nodes in the context for
      # example, you could simply define a +process_call+ method in the context that will be invoked with each call Sexp (S-expression, see
      # http://en.wikipedia.org/wiki/S_expression) that is processed by the Excellent processor.
      #
      #  def process_call(exp)
      #    super
      #    do_something()
      #  end
      #
      # Custom <b>processor methods must always call +super+</b> since there might be several processor methods defined in several modules that are in the
      # included in the context and all of these have to be invoked. Also <b>processor methods must not modify the passed Sexp</b> since other processor
      # methods also need the complete Sexp. If you have to modify the Sexp in a processor method, deep clone it:
      #
      #  exp = exp.deep_clone
      #
      class SexpContext

        # The parent context
        attr_reader :parent

        # The name of the code fragment the context is bound to (e.g. 'User' for a +class+)
        attr_reader :name

        # The file the code fragment was read from
        attr_reader :file

        # The line the code fragment is located at
        attr_reader :line

        # Initializes a SexpContext.
        #
        # Always call +super+ in inherited custom contexts!
        #
        # === Parameters
        #
        # * <tt>exp</tt> - The Sexp (S-expression, see http://en.wikipedia.org/wiki/S_expression) the context is created for.
        # * <tt>parent</tt> - The parent context.
        def initialize(exp, parent = nil)
          @exp        = exp
          @parent     = parent
          @file       = exp.file
          @line       = exp.line
          @full_name  = nil
        end

        # Gets the full name of the code fragment the context is bound to. For a method +name+ might be '+add_product+' while +full_name+ might be
        # 'Basket#add_product'.
        def full_name
          return @full_name if @full_name
          return @name if @parent.blank?
          "#{@parent.full_name}::#{@name}"
        end

        def method_missing(method, *args) #:nodoc:
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
