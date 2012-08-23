module Twoffein
  class Util
    def self.compact!(hash)
      hash.reject! { |k,v| v.nil? || v.empty? }
    end
  end
end
