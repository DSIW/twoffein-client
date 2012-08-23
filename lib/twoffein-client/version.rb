module Twoffein
  module Server; VERSION = "0.2";   end

  module Client
    VERSION = File.read(File.absolute_path("../../../VERSION", __FILE__))
  end
end
