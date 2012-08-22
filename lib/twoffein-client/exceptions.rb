module Twoffein
  module Server
    class Error < StandardError
      attr_reader :type, :message
      def initialize(type, message)
        @type = type
        @message = message
      end

      def to_s
        "Server::Error: #@type (#@message)"
      end
    end
  end
end
