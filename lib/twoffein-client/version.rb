module Twoffein
  module Server; VERSION = "0.2";   end

  module Client
    VERSION = File.read("VERSION")
  end
end
