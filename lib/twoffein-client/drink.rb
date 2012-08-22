# encoding: utf-8

module Twoffein
  class Drink
    attr_reader :name, :key, :brand

    def initialize(name, key=nil, brand=false)
      @name  = name.to_s
      @key   = (key ? key : key_of(name)).to_sym
      @brand = !!brand
    end

    def to_s
      "#@name  (#@key)"
    end

    def ==(drink)
      name == drink.name &&
        key == drink.key &&
        brand == drink.brand
    end

    private

    def key_of(name)
      key = name.dup
      changes = {
        'ü' => 'ue',
        'Ü' => 'Ue',
        'ö' => 'oe',
        'Ö' => 'Oe',
        'ä' => 'ae',
        'Ä' => 'Ae',
      }
      changes.each { |orig, trans| key.gsub!(orig, trans) }

      removeables = [/\W/]
      removeables.each { |r| key.gsub!(r, '') }

      key.downcase.to_sym
    end
  end
end
