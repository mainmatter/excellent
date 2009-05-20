require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports code that uses +for+ loops as in:
      #
      #  for user in @users
      #    do_something(user)
      #  end
      #
      # The use of for loops in Ruby is contrary to the language's basic concept of iterators. The above statement would better be written as:
      #
      #  @users.each do |user|
      #    do_something(user)
      #  end
      #
      # ==== Applies to
      #
      # * +for+ loops
      class ForLoopCheck < Base

        def initialize #:nodoc:
          super
          @interesting_nodes = [:for]
        end

        def evaluate(context) #:nodoc:
          add_warning(context, 'For loop used.')
        end

      end

    end

  end

end
