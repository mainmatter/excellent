require 'melbourne'
require 'erb'

module Simplabs

  module Excellent

    class Parser #:nodoc:

      @@haml = false

      def parse(content, filename)
        content = ::ERB.new(content, nil, '-').src if filename =~ /\.erb$/
        content = ::Haml::Engine.new(content).precompiled if filename =~ /\.haml$/ && @@haml
        Melbourne::Parser.parse_string(content, filename)
      rescue Exception
        #continue on errors
      end

      def self.activate_haml!
        @@haml = true
      end

    end

  end

end

begin
  require 'haml'
  Simplabs::Excellent::Parser.activate_haml!
rescue LoadError
end
