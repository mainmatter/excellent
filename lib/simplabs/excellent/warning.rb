require 'simplabs/excellent/extensions/string'

module Simplabs

  module Excellent

    # The warnings returned by Excellent provide information about the +file+ the *possibly* problematic code was found in as well as the +line+ of the
    # occurence, a warning message and a Hash with specific information about the warning.
    #
    # Warnings also provide the message template that was used to generate the message. The message template contains tokens like <tt>{{token}}</tt> that
    # correspond to the valeus in the +info+ hash, e.g.:
    #
    #  '{{method}} has abc score of {{score}}.'
    #  { :method => 'User#full_name', :score => 10 }
    class Warning

      # The check that produced the warning
      attr_reader :check

      # The name of the file the check found the problematic code in
      attr_reader :filename

      # The file number where the check found the problematic code
      attr_reader :line_number

      # The warning message
      attr_reader :message

      # Additional info for the warning (see above)
      attr_reader :info

      # The template used to produce the warning (see above)
      attr_reader :message_template

      def initialize(check, message, filename, line_number, info) #:nodoc:
        @check       = check.to_s.underscore.to_sym
        @info        = info
        @filename    = filename
        @line_number = line_number.to_i

        @message = ''
        if !message.nil?
          @message_template = message
          @info.each { |key, value| message.gsub!(/\{\{#{key}\}\}/, value.to_s) }
          @message = message
        end
      end

    end

  end

end
