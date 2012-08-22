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
        new(selected)
        #all.grep(search) # TODO see :===
      end
    end

    def add(drink)
      raise ArgumentError, "drink has to be of type Drink" unless drink.is_a? Drink
      @all << drink
    end

    def to_s
      name_max_length = @all.map { |d| d.name.length }.max
      pre_key  = "  ("
      post_key = ")"

      # Calc max length of line
      length = lambda do |drink|
        key = drink.key
        [pre_key, key, post_key].map { |cont|
          cont.length
        }.push(name_max_length).reduce(&:+)
      end
      max_line = @all.map { |d| length.call(d) }.max

      # Header
      header = ["Drink".ljust(name_max_length), pre_key, "key", post_key].join
      line = "-"*max_line

      # Drinks
      drinks = @all.map { |d|
        name = d.name
        key = d.key
        [name.ljust(name_max_length), pre_key, key, post_key].join
      }.join("\n")

      # All
      [header, line, drinks].join("\n")
    end

    private

    # Delegates method call to @all if it has defined this method
    def method_missing(method, *args, &block)
      if @all.respond_to? method
        @all.send(method, *args, &block)
      else
        super(method, *args, &block)
      end
    end
  end
end
