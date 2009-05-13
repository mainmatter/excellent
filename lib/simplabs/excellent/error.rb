require 'simplabs/excellent/extensions/string'

module Simplabs

  module Excellent

    class Error

      attr_reader :check, :info, :filename, :line_number, :message, :message_template

      def initialize(check, message, filename, line_number, info)
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
