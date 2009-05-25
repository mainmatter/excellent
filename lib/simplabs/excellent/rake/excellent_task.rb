require 'rake'

module Simplabs

  module Excellent

    module Rake

      # A custom rake task for Excellent.
      class ExcellentTask < ::Rake::TaskLib

        # The Name of the task, defaults to :excellent.
        attr_accessor :name

        # The format to use for the output. This is either html:<filename> or nothing
        attr_reader :format

        # The paths to process (specify file names or directories; will recursively process all ruby files if a directory are given).
        attr_reader :paths

        # Initializes an ExcellentTask with the name +name+.
        def initialize(name = :excellent)
          @name   = name
          @paths  = nil || []
          @format = nil
          yield self if block_given?
          define
        end

        def format=(format) #:nodoc:
          if format =~ /html:[^\s]+/
            @format = format 
          else
            raise ArgumentError.new("Invalid format #{format}; only 'html:<filename>' is currently supported!")
          end
        end

        def paths=(paths) #:nodoc:
          if paths.is_a?(String)
            @paths = [paths] 
          elsif paths.is_a?(Array)
            @paths = paths
          else
            raise ArgumentError.new('Specify paths either as a String or as an Array!')
          end
        end

        def define
          unless ::Rake.application.last_comment
            desc 'Analyse the code with Excellent'
          end
          task name do
            paths = @paths.join(' ')
            system("excellent #{@format} #{paths}")
            $stdout.puts("Wrote result to #{@format.split(':').last}") unless @format.blank?
          end
        end

      end

    end

  end

end
