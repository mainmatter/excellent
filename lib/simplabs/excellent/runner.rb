require 'pp'
require 'yaml'

require 'simplabs/excellent/parsing/parser'
require 'simplabs/excellent/parsing/code_processor'

module Simplabs

  module Excellent

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
        :'Rails::AttrProtectedCheck'     => { },
        :'Rails::AttrAccessibleCheck'    => { }
      }
      
      attr_writer :config

      def initialize(*checks)
        @config = DEFAULT_CONFIG
        @checks = checks unless checks.empty?
        @parser = Parsing::Parser.new
      end

      def check(filename, content)
        @checks ||= load_checks
        @processor ||= Parsing::CodeProcessor.new(@checks)
        node = parse(filename, content)
        @processor.process(node)
      end

      def check_content(content)
        check('dummy-file.rb', content)
      end
  
      def check_file(filename)
        check(filename, File.read(filename))
      end

      def errors
        @checks ||= []
        @checks.collect { |check| check.errors }.flatten
      end

      private

        def parse(filename, content)
          @parser.parse(content, filename)
        end

        def load_checks
          check_objects = []
          DEFAULT_CONFIG.each_pair do |key, value| 
            klass = eval("Simplabs::Excellent::Checks::#{key.to_s}")
            check_objects << (value.empty? ? klass.new : klass.new(value))
          end
          check_objects
        end

    end

  end

end
