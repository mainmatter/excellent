require 'simplabs/excellent/formatters/base'

module Simplabs

  module Excellent

    module Formatters

      class Text < Base #:nodoc:

        def initialize(stream = $stdout)
          super
          @total_warnings = 0
        end

        def start
          @stream.puts "\n  Excellent result:\n"
        end

        def file(filename)
          @stream.puts "\n  #{filename}\n"
        end

        def warning(warning)
          @stream.puts "    * Line #{warning.line_number.to_s.lpad(3)}: \e[33m#{warning.message}\e[0m"
          @total_warnings += 1
        end

        def end
          @stream.puts "\n  Found #{@total_warnings} warnings.\n\n"
        end

      end

    end

  end

end
