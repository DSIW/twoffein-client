require_relative "drink"

module Twoffein
  class Drinks
    attr_reader :all

    def initialize(subset=nil)
      unless subset
        @all ||= Drink.get("list")
        return @all.map! { |drink| Drink.new(drink[:drink], drink[:key], drink[:brand]) }
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

      def find(key)
        all.each { |d| return d if d.key == key }
        nil
      end
      alias :[] :find

      def search search
        selected = all.select { |drink| drink.to_s =~ search }
        #all.grep(search) # TODO see :===
        new(selected).to_s
      end
    end

    def add(drink)
      raise ArgumentError, "drink has to be of type Drink" unless drink.is_a? Drink
      @all << drink
    end
    alias :<< :add

    def to_s
      max_length = self.class.names.map{ |d| d.length }.max
      @all.map do |d|
        name = d.name
        key = d.key
        "#{name.ljust(max_length+1)}(#{key})"
      end.join("\n")
    end
  end
end
