module Simplabs

  module Excellent

    module Formatters

      # The base class for all formatters.
      class Base

        # Initializes the formatter.
        #
        # Always call +super+ in custom formatters!
        def initialize(stream)
          @stream = stream
        end

        # Called when the Simplabs::Excellent::Runner starts processing code.
        #
        # The text formatter renders the heading here ('Excellent result')
        def start
        end

        # Called whenever the Simplabs::Excellent::Runner processes a file. Yields the formatter
        #
        # You have to <tt>yield self</tt> in custom formatters. +file+ is called like that by the runner:
        #
        #  formatter.file(filename) do |formatter|
        #    warnings.each { |warning| formatter.warning(warning) }
        #  end
        def file(filename)
        end

        # Called when the Simplabs::Excellent::Runner found a warning. This warning will always refer to the last filename, +file+ was invoked with.
        def warning(warning)
        end

        # Called when the Simplabs::Excellent::Runner ends processing code.
        #
        # The text formatter renders the footer here ('Found <x> warnings').
        def end
        end

      end

    end

  end

end
