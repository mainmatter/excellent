require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports global variables. Global variables introduce strong dependencies between otherwise unrelated parts of code and their use is
      # usually considered extremely bad style.
      #
      # ==== Applies to
      #
      # * global variables
      class GlobalVariableCheck < Base

        DEFAULT_WHITELIST = %w(! @ & ` ' + \d+ ~ = / \\ , ; \. < > _ 0 \* $ \? : " DEBUG FILENAME LOAD_PATH stdin stdout stderr VERBOSE -0 -a -d -F -i -I -l -p -v).map do |global_name|
          Regexp.new("^#{global_name}$")
        end

        def initialize(options = {}) #:nodoc:
          super
          @whitelist            = options[:whitelist] ||= DEFAULT_WHITELIST
          @interesting_contexts = [Parsing::GvarContext, Parsing::GasgnContext]
          @interesting_files    = [/\.rb$/, /\.erb$/]
        end

        def evaluate(context) #:nodoc:
          if context.is_a?(Parsing::GasgnContext) || !@whitelist.any? { |whitelisted| context.full_name =~ whitelisted }
            add_warning(context, 'Global variable {{variable}} used.', { :variable => context.full_name })
          end
        end

      end

    end

  end

end
