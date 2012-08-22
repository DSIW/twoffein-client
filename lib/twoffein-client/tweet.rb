require_relative "http"
require_relative "exceptions"
require_relative "drinks"

module Twoffein
  class Tweet
    attr_accessor :drink,
      :target_screen_name

    def initialize drink_key, target_screen_name=nil
      @drink = drink_key.to_sym
      @target_screen_name = target_screen_name
    end

    def post
      info = HTTP.post("tweet", {
        :drink => @drink,
        :target_screen_name => @target_screen_name
      })
      raise Server::Error.new(info[:code], info[:error]) if info.has_key? :error
      info
    end
    alias publish post

    def to_s
      s = "Ich trinke gerade #{Drinks[@drink].name}"
      s << " mit #{@target_screen_name}" if @target_screen_name
      s << "."
    end
  end
end
