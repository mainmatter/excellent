require 'rubygems'
require 'ruby_parser'
require 'erb'

module Simplabs

  module Excellent

    module Parsing

      class Parser #:nodoc:

        def parse(content, filename)
          return silent_parse(content, filename)
        rescue Exception
          #continue on errors
        end

        private

          def silent_parse(content, filename)
            if @parser.nil?
              @parser = RUBY_VERSION =~ /2\.0/ ? Ruby19Parser.new : RubyParser.for_current_ruby
            else
              @parser.reset
            end
            content = ::ERB.new(content, nil, '-').src if filename =~ /\.erb$/
            sexp = @parser.parse(content, filename)
            sexp
          end

      end

    end

  end

end
