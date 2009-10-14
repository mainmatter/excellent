module Simplabs

  module Excellent

    module Parsing

      # Parser that counts the different types of lines for the given set of files.
      #
      class LOCParser

        # The files to count the lines for
        #
        attr_accessor :files

        def initialize(files) #:nodoc:
          @files  = collect_files(files)
        end

        # Returns a hash with file name as key and a hash of counts as value.
        #
        #  { file => { :total => 9, :code => 3, ... }, ... }
        #
        # ==== Parameters
        #
        # * <tt>force</tt> - The count is cached once it was calculated. Specify +force+ to force recalculation.
        def count(force = false)
          @count = recount if @count.nil? || force
        end

        private

          def recount
            count = {}
            files.each do |file|
              total, code, comment, blank = *line_count(file)
              count[file] = {
                :total   => total,
                :code    => code,
                :comment => comment,
                :blank   => blank
              }
            end
            count
          end

          def line_count(file)
            total, code, comment = 0, 0, 0
            in_block_comment = false
            File.open(file) do |file|
              while line = file.gets
                total += 1
                case line
                when /^\s*$/
                  comment += 1 if in_block_comment
                  next
                when /^=begin/
                  in_block_comment = true
                  comment += 1
                when /^=end/
                  comment += 1
                  in_block_comment = false
                when /^\s*#/
                  comment += 1
                else
                  code += 1 if !in_block_comment
                  comment += 1 if in_block_comment
                end
              end
            end
            blank = total - code - comment
            return total, code, comment, blank
          end

          def collect_files(paths)
            files = []
            paths.each do |path|
              if File.file?(path)
                files << path
              elsif File.directory?(path)
                files += Dir.glob(File.join(path, '**/*.{rb}'))  # TODO: erb support ?
              else
                raise ArgumentError.new("#{path} is neither a file or a directory!")
              end
            end
            files
          end

      end

    end

  end

end
