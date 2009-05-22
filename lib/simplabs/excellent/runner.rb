require 'pp'
require 'yaml'
require 'simplabs/excellent/parsing/parser'
require 'simplabs/excellent/parsing/code_processor'

module Simplabs

  module Excellent

    # The Runner is the interface to invoke parsing and processing of source code. You can pass either a String containing the code to process or the
    # name of a file to read the code to process from.
    class Runner

      DEFAULT_CONFIG = {
        :AssignmentInConditionalCheck    => { },
        :CaseMissingElseCheck            => { },
        :ClassLineCountCheck             => { :threshold      => 300 },
        :ClassNameCheck                  => { :pattern         => /^[A-Z][a-zA-Z0-9]*$/ },
        :SingletonVariableCheck          => { },
        :CyclomaticComplexityBlockCheck  => { :complexity      => 4 },
        :CyclomaticComplexityMethodCheck => { :complexity      => 8 },
        :EmptyRescueBodyCheck            => { },
        :ForLoopCheck                    => { },
        :MethodLineCountCheck            => { :line_count      => 20 },
        :MethodNameCheck                 => { :pattern         => /^[_a-z<>=\[|+-\/\*`]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/ },
        :ModuleLineCountCheck            => { :line_count      => 300 },
        :ModuleNameCheck                 => { :pattern         => /^[A-Z][a-zA-Z0-9]*$/ },
        :ParameterNumberCheck            => { :parameter_count => 3 },
        :FlogMethodCheck                 => { },
        :FlogBlockCheck                  => { },
        :FlogClassCheck                  => { },
        :'Rails::AttrProtectedCheck'     => { },
        :'Rails::AttrAccessibleCheck'    => { }
      }

      attr_accessor :config #:nodoc:

      # Initializes a Runner
      #
      # ==== Parameters
      #
      # * <tt>checks</tt> - The checks to apply - pass instances of the various check classes. If no checks are specified, all checks will be applied.
      def initialize(*checks)
        @config = DEFAULT_CONFIG
        @checks = checks unless checks.empty?
        @parser = Parsing::Parser.new
      end

      # Processes the +code+ and sets the file name of the warning to +filename+
      #
      # ==== Parameters
      #
      # * <tt>filename</tt> - The name of the file the code was read from.
      # * <tt>code</tt> - The code to process (String).
      def check(filename, code)
        @checks ||= load_checks
        @processor ||= Parsing::CodeProcessor.new(@checks)
        node = parse(filename, code)
        @processor.process(node)
      end

      # Processes the +code+, setting the file name of the warnings to '+dummy-file.rb+'
      #
      # ==== Parameters
      #
      # * <tt>code</tt> - The code to process (String).
      def check_code(code)
        check('dummy-file.rb', code)
      end
  
      # Processes the file +filename+. The code will be read from the file.
      #
      # ==== Parameters
      #
      # * <tt>filename</tt> - The name of the file to read the code from.
      def check_file(filename)
        check(filename, File.read(filename))
      end

      # Processes the passed +paths+
      #
      # ==== Parameters
      #
      # * <tt>paths</tt> - The paths to process (specify file names or directories; will recursively process all ruby files if a directory are given).
      # * <tt>formatter</tt> - The formatter to use. If a formatter is specified, its +start+, +file+, +warning+ and +end+ methods will be called
      def check_paths(paths, formatter = nil)
        formatter.start if formatter
        collect_files(paths).each do |path|
          check_file(path)
          format_file_and_warnings(formatter, path) if formatter
        end
        formatter.end if formatter
      end

      # Gets the warnings that were produced by the checks.
      def warnings
        @checks ||= []
        @checks.collect { |check| check.warnings }.flatten
      end

      private

        def parse(filename, code)
          @parser.parse(code, filename)
        end

        def load_checks
          check_objects = []
          DEFAULT_CONFIG.each_pair do |key, value| 
            klass = eval("Simplabs::Excellent::Checks::#{key.to_s}")
            check_objects << (value.empty? ? klass.new : klass.new(value))
          end
          check_objects
        end

        def collect_files(paths)
          files = []
          paths.each do |path|
            if File.file?(path)
              files << path
            elsif File.directory?(path)
              files += Dir.glob(File.join(path, '**/*.rb'))
            else
              raise ArgumentError.new("#{path} is neither a File nor a directory!")
            end
          end
          files
        end

        def format_file_and_warnings(formatter, filename)
          warnings = @checks.map { |check| check.warnings_for(filename) }.flatten
          if warnings.length > 0
            formatter.file(filename) do |formatter|
              warnings.sort { |x, y| x.line_number <=> y.line_number }.each { |warning| formatter.warning(warning) }
            end
          end
        end

    end

  end

end
