require 'simplabs/excellent/warning'

module Simplabs

  module Excellent

    module Checks

      # This is the base class for all code checks. All checks must specify +interesting_nodes+. When one of these nodes is processed by Excellent, it
      # will invoke the +evaluate_node+ method of all checks that specify the node as one if their +interesting_nodes+.
      class Base

        attr_reader :warnings

        # An array of node types that are interesting for the check. These are symbols as returned by RubyParser (see http://parsetree.rubyforge.org/ruby_parser/),
        # e.g. <tt>:if</tt> or <tt>:defn</tt>
        attr_reader :interesting_nodes

        def initialize #:nodoc:
          @warnings = []
        end

        # This method is called whenever Excellent processes a node that the check specified as one of the nodes it is interested in (see interesting_nodes).
        #
        # ==== Parameters
        #
        # * <tt>context</tt> - This is the last context the code processor has constructed. It contains all information required to execute the check (see Simplabs::Excellent::Parsing::SexpContext).
        def evaluate_node(context)
          evaluate(context)
        end

        # Adds a warning
        #
        # ==== Parameters
        #
        # * <tt>context</tt> - The context the check has been executed on.
        # * <tt>message</tt> - The warning message.
        # * <tt>info</tt> - The information hash that contains more info on the finding.
        # * <tt>offset</tt> - The line offset that is added to the context's line property.
        def add_warning(context, message, info = {}, offset = 0)
          klass = self.class
          @warnings << Simplabs::Excellent::Warning.new(klass, message, context.file, context.line + offset, info)
        end
  
        def warnings_for(filename) #:nodoc:
          warnings.select { |warning| warning.filename == filename }
        end
  
      end

    end

  end

end
