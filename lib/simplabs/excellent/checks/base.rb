require 'simplabs/excellent/warning'

module Simplabs

  module Excellent

    module Checks

      # This is the base class for all code checks. All checks must specify +interesting_contexts+. When one of these contexts is processed by Excellent, it
      # will invoke the +evaluate_context+ method of all checks that specify the context as one if their +interesting_contexts+.
      class Base

        attr_reader :warnings #:nodoc:

        attr_reader :options #:nodoc:

        # An array of contexts that are interesting for the check. These contexts are based on symbols as returned by RubyParser (see
        # http://parsetree.rubyforge.org/ruby_parser/) and add some additional data,
        # e.g. <tt>Ifcontext</tt> or <tt>MethodContext</tt>
        attr_reader :interesting_contexts

        # An array of regular expressions for file names that are interesting for the check. These will usually be path extensions rather than longer
        # patterns (e.g. *.rb as well as *.erb files or *.rb files only).
        #
        # Defaults to /\.rb$/. If you do not specify anything else in custom checks, only *.rb files will be processed
        attr_reader :interesting_files

        def initialize(options = {}) #:nodoc:
          @options              = options
          @interesting_contexts = []
          @warnings             = []
          @interesting_files    = [/\.rb$/]
        end

        # This method is called whenever Excellent processes a context that the check specified as one of the contexts it is interested in (see
        # interesting_contexts).
        #
        # ==== Parameters
        #
        # * <tt>context</tt> - This is the last context the code processor has constructed. It contains all information required to execute the check (see Simplabs::Excellent::Parsing::SexpContext).
        def evaluate_context(context)
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
          @warnings << Simplabs::Excellent::Warning.new(message, context.file, context.line + offset, info)
        end

        def warnings_for(filename) #:nodoc:
          warnings.select { |warning| warning.filename == filename }
        end

      end

    end

  end

end
