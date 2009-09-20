require 'rubygems'
require 'ruby_parser'
require 'facets'
require 'erb'

module Simplabs

  module Excellent

    module Parsing

      class Parser #:nodoc:

        def parse(content, filename)
          silence_stream(STDERR) do 
            return silent_parse(content, filename)
          end
        rescue Exception
          #continue on errors
        end

        private

          def silent_parse(content, filename)
            @parser ||= RubyParser.new
            content = ::ERB.new(content, nil, '-').src if filename =~ /\.erb$/
            sexp = @parser.parse(content, filename)
            sexp
          end

      end

    end

  end

end
