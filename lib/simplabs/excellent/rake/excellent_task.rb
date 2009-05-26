require 'rake'

module Simplabs

  module Excellent

    module Rake #:nodoc:

      # A special rake task for Excellent.
      class ExcellentTask < ::Rake::TaskLib

        # The Name of the task, defaults to <tt>:excellent</tt>.
        attr_accessor :name

        # Specifies whether to output HTML; defaults to false. Assign a file name to output HTML to that file.
        attr_accessor :html

        # The paths to process (specify file names or directories; will recursively process all ruby files if a directory is given).
        attr_accessor :paths

        # Initializes an ExcellentTask with the name +name+.
        def initialize(name = :excellent)
          @name  = name
          @paths = nil || []
          @html  = false
          yield self if block_given?
          define
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

        private

          def define
            unless ::Rake.application.last_comment
              desc 'Analyse the code with Excellent'
            end
            task name do
              paths = @paths.join(' ')
              format = @html ? " html:#{@html}" : ''
              system("excellent#{format} #{paths}")
              $stdout.puts("\nWrote Excellent result to #{@html}\n\n") if @html
            end
          end

      end

    end

  end

end
