require 'rubygems'
require 'ruby_parser'
require 'facets'

module Simplabs

  module Excellent

    module Parsing

      class Parser

        def parse(content, filename)
          silence_stream(STDERR) do 
            return silent_parse(content, filename)
          end
        end

        private

          def silent_parse(content, filename)
            @parser ||= RubyParser.new
            sexp = @parser.parse(content, filename)
            sexp
          end

      end

    end

  end

end
