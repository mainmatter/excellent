require 'pp'
require 'yaml'
require 'simplabs/excellent/parsing/parser'
require 'simplabs/excellent/parsing/code_processor'

module Simplabs

  module Excellent

    # The Runner is the interface to invoke parsing and processing of source code. You can pass either a String containing the code to process or the
    # name of a file to read the code to process from.
    class Runner

      DEFAULT_CHECKS_CONFIG = {
        :AbcMetricMethodCheck                 => {},
        :AssignmentInConditionalCheck         => {},
        :CaseMissingElseCheck                 => {},
        :ClassLineCountCheck                  => {},
        :ClassNameCheck                       => {},
        :ControlCouplingCheck                 => {},
        :CyclomaticComplexityBlockCheck       => {},
        :CyclomaticComplexityMethodCheck      => {},
        :EmptyRescueBodyCheck                 => {},
        :FlogBlockCheck                       => {},
        :FlogClassCheck                       => {},
        :FlogMethodCheck                      => {},
        :ForLoopCheck                         => {},
        :GlobalVariableCheck                  => {},
        :MethodLineCountCheck                 => {},
        :MethodNameCheck                      => {},
        :ModuleLineCountCheck                 => {},
        :ModuleNameCheck                      => {},
        :ParameterNumberCheck                 => {},
        :ClassVariableCheck                   => {},
        :'Rails::AttrProtectedCheck'          => {},
        :'Rails::AttrAccessibleCheck'         => {},
        :'Rails::InstanceVarInPartialCheck'   => {},
        :'Rails::ValidationsCheck'            => {},
        :'Rails::ParamsHashInViewCheck'       => {},
        :'Rails::SessionHashInViewCheck'      => {},
        :'Rails::CustomInitializeMethodCheck' => {}
      }

      attr_reader :checks

      # Initializes a Runner
      #
      # ==== Parameters
      #
      # * <tt>checks_config</tt> - The check configuration to use; You can either specify an array of specs to use like this
      #                              [:ClassLineCountCheck => { :threshold => 10 }]
      #                            or you can specify a hash that will then be merged with the default configuration:
      #                              { :ClassNameCheck => { pattern: 'test' }, :ClassLineCountCheck => { :threshold => 10 } }
      #                            You can enable/disable a check by setting the value of the hash to sth. truthy/falsy:
      #                              { :ClassNameCheck => false, :AbcMetricMethodCheck => {} }
      def initialize(checks_config = {})
        @checks = load_checks(checks_config)
        @parser = Parsing::Parser.new
      end

      # Processes the +code+ and sets the file name of the warning to +filename+
      #
      # ==== Parameters
      #
      # * <tt>filename</tt> - The name of the file the code was read from.
      # * <tt>code</tt> - The code to process (String).
      def check(filename, code)
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
      # * <tt>paths</tt> - The paths to process (specify file names or directories; will recursively process all ruby files if a directory is given).
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
        @checks.collect { |check| check.warnings }.flatten
      end

      private

        def parse(filename, code)
          @parser.parse(code, filename)
        end

        def load_checks(checks_config)
          effective_checks = checks_config.is_a?(Array) ? checks_config : [DEFAULT_CHECKS_CONFIG.deep_merge(checks_config.deep_symbolize_keys)]
          check_objects = []
          effective_checks.each do |check|
            check.each do |name, check_config|
              if !!check_config
                klass = name.to_s.split('::').inject(::Simplabs::Excellent::Checks) do |mod, class_name|
                  mod.const_get(class_name)
                end
                check_objects << klass.new(check_config.is_a?(Hash) ? check_config.deep_symbolize_keys : {})
              end
            end
          end
          check_objects
        end

        def collect_files(paths)
          files = []
          paths.each do |path|
            if File.file?(path)
              files << path
            elsif File.directory?(path)
              files += Dir.glob(File.join(path, '**/*.{rb,erb}'))
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
