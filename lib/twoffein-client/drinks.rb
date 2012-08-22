require_relative "drink"
require_relative "http"

module Twoffein
  class Drinks
    attr_reader :all

    def initialize(subset=nil)
      unless subset
        @all ||= Drinks.get
        return @all.map! do |drink|
          name = drink[:drink]
          key = drink[:key].to_sym
          brand = (drink[:brand] == "0" ? false : true)
          Drink.new(name, key, brand)
        end
      end

      if subset.is_a? Array
        @all = subset
      else
        @all = [subset]
      end
    end

    class << self
      def all;    new.all;                 end
      def names;  all.map { |d| d.name  }; end
      def keys;   all.map { |d| d.key   }; end
      def brands; all.map { |d| d.brand }; end

      def get
        HTTP.get("drinks", :drink => :all)
      end

      def find(key)
        key = key.to_sym
        all.each { |d| return d if d.key == key }
        nil
      end
      alias :[] :find

      def search search
        search = /#{search}/i unless search.is_a? Regexp
        selected = all.select { |drink| drink.to_s =~ search }
        new(selected).all
        #all.grep(search) # TODO see :===
      end
    end

    def add(drink)
      raise ArgumentError, "drink has to be of type Drink" unless drink.is_a? Drink
      @all << drink
    end
    alias :<< :add

    def length
      @all.length
    end

    def to_s
      max_length = @all.map { |d| d.name.length }.max
      @all.map { |d|
        name = d.name
        key = d.key
        "#{name.ljust(max_length)}  (#{key})"
      }.join("\n")
    end
  end
end
