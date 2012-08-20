module Twoffein
  class Util
    def self.format(obj)
      sprintf("%-30.30s", obj)
    end

    def self.compact!(hash)
      hash.reject! { |k,v| v.nil? || v.empty? }
    end
  end
end
