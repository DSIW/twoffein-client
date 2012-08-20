require_relative "http"

module Twoffein
  class Drink
    attr_reader :name, :key, :brand

    def initialize(name, key=nil, brand=true)
      @name = name
      @key = key ? key : name.downcase
      @brand = brand
    end

    def self.get(name)
      HTTP.get("drinks", :drink => name)
    end

    def to_s
      "#@name  (#@key)"
    end
  end
end
