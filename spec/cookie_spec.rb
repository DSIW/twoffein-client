require_relative "spec_helper"
include SpecHelper

describe Cookie do
  it "#init" do
    cookie = Cookie.new "TargetUser"
    cookie.target_screen_name.should == "TargetUser"
  end

  it "#post" do
    VCR.use_cassette("cookie") do
      cookie = Cookie.new "UserDoesNotExistTest"
      expect { cookie.post }.to raise_error(Server::Error, "Profile not found.")
      cookie = Cookie.new SCREEN_NAME
      expect { cookie.post }.to raise_error(Server::Error, "Lol.")
      cookie = Cookie.new "BakeRolls"
      cookie.post.should include(:code, :info)
    end
  end

  it "#to_s" do
    cookie = Cookie.new "TargetUser"
    cookie.to_s.should == "Ich gebe TargetUser einen Keks!"
  end
end
