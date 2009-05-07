require 'pp'
require 'yaml'

require 'simplabs/excellent/core/parser'
require 'simplabs/excellent/core/code_processor'

module Simplabs

  module Excellent

    module Core

      class ParseTreeRunner

        DEFAULT_CONFIG = {
          :AssignmentInConditionalCheck    => { },
          :CaseMissingElseCheck            => { },
          :ClassLineCountCheck             => { :threshold      => 300 },
          :ClassNameCheck                  => { :pattern         => /^[A-Z][a-zA-Z0-9]*$/ },
          :ClassVariableCheck              => { },
          :CyclomaticComplexityBlockCheck  => { :complexity      => 4 },
          :CyclomaticComplexityMethodCheck => { :complexity      => 8 },
          :EmptyRescueBodyCheck            => { },
          :ForLoopCheck                    => { },
          :MethodLineCountCheck            => { :line_count      => 20 },
          :MethodNameCheck                 => { :pattern         => /^[_a-z<>=\[|+-\/\*`]+[_a-z0-9_<>=~@\[\]]*[=!\?]?$/ },
          :ModuleLineCountCheck            => { :line_count      => 300 },
          :ModuleNameCheck                 => { :pattern         => /^[A-Z][a-zA-Z0-9]*$/ },
          :ParameterNumberCheck            => { :parameter_count => 3 }
        }
      
        attr_writer :config
      
        def initialize(*checks)
          @config = DEFAULT_CONFIG
          @checks = checks unless checks.empty?
          @parser = Parser.new
        end
      
        def check(filename, content)
          @checks ||= load_checks
          @processor ||= CodeProcessor.new(@checks)
          node = parse(filename, content)
          @processor.process(node)
        end

        def check_content(content)
          check("dummy-file.rb", content)
        end
  
        def check_file(filename)
          check(filename, File.read(filename))
        end
  
        def errors
          @checks ||= []
          all_errors = @checks.collect {|check| check.errors}
          all_errors.flatten
        end
      
        private
      
          def parse(filename, content)
            begin
              @parser.parse(content, filename)
            rescue Exception => e
              puts "#{filename} looks like it's not a valid Ruby file. Skipping..." if ENV["ROODI_DEBUG"]
              nil
            end
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

end
