module Simplabs

  module Excellent

    # Counts the different types of lines for the given set of files.
    #
    class LOCParser

      attr_accessor :files

      #
      def initialize(files)
        @files  = collect_files(files)
      end

      # Returns a hash with file name as key and a hash of counts as value.
      #
      #  { file => { :total => 9, :code => 3, ... }, ... }
      #
      # The +count+ is cached. Use #recount to recalculate the counts.
      def count
        @count ||= recount
      end

      #
      def recount
        cnt = {}
        files.each do |file|
          total, code, comment, blank = *line_count(file)
          cnt[file] = {
            :total   => total,
            :code    => code,
            :comment => comment,
            :blank   => blank
          }
        end
        @count = cnt
      end

      # Return line counts for a file.
      #
      def line_count(file)
        l, c, t, r = 0, 0, 0, 0

        rb = false  #tb = false

        File.open(file) do |f|
          while line = f.gets
            l += 1
            case line
            when /^\s*$/
              #s += 1
              next
            #when /^=begin\s+test/
            #  tb = true; t+=1
            when /^=begin/
              rb = true; r+=1
            when /^=end/
              t+=1 if tb
              r+=1 if rb
              rb, tb = false, false
            when /^\s*#/
              r += 1
            else
              c+=1 if !rb #or tb
              r+=1 if rb
              #t+=1 if tb
            end
          end
        end

        s = l - c - r

        return l, c, r, s
      end

      #
      def collect_files(paths)
        files = []
        paths.each do |path|
          if File.file?(path)
            files << path
          elsif File.directory?(path)
            #files += Dir.glob(File.join(path, '**/*.{rb,erb}'))
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
