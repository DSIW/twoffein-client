require_relative "exceptions"
require_relative "http"

module Twoffein
  class Cookie
    attr_accessor :target_screen_name

    def initialize target_screen_name
      @target_screen_name = target_screen_name
    end

    def post
      info = HTTP.post("cookie", :target_screen_name => @target_screen_name)
      raise Server::Error.new(info[:code], info[:error]) if info.has_key? :error
      info
    end
    alias send post

    def to_s
      "Ich gebe #@target_screen_name einen Keks!"
    end
  end
end
