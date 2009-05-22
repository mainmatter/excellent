require 'simplabs/excellent/runner'
require 'simplabs/excellent/formatters'

module Simplabs

  module Excellent

    class CommandLineRunner < Runner #:nodoc:

      def initialize(*checks)
        super
        @formatter = Formatters::Text.new
        @formatter.start
      end

      def check_paths(paths)
        paths.each do |path|
          if File.file?(path)
            check_file(path)
          elsif File.directory?(path)
            Dir.glob(File.join(path, '**/*.rb')).each { |file| check_file(file) }
          else
            next
          end
        end
      end

      def check_file(filename)
        super
        @formatter.file(filename, (@checks || []).collect { |check| check.warnings }.flatten)
      end

    end

  end

end
