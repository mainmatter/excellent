module Simplabs

  module Excellent

    module Extensions #:nodoc:

      ::Hash.class_eval do

        # taken from https://github.com/Offirmo/hash-deep-merge
        def deep_merge(other)
          hash = {}
          merge(other) do |key, oldval, newval|
            hash[key] = oldval.class == self.class ? oldval.rmerge(newval) : newval
          end
        end

      end

    end

  end

end
