require_relative "spec_helper"
include SpecHelper

describe Tweet do
  it "#init without default" do
    tweet = Tweet.new :clubmate, "BakeRolls"
    tweet.drink.should eq :clubmate
    tweet.target_screen_name.should eq "BakeRolls"
  end

  it "#init without default" do
    tweet = Tweet.new "clubmate", "BakeRolls"
    tweet.drink.should eq :clubmate
    tweet.target_screen_name.should eq "BakeRolls"
  end

  it "#post with target_screen_name" do
    VCR.use_cassette("tweet") do
      tweet = Tweet.new "clubmate", "UserDoesNotExistTest"
      info = tweet.post
      info[:code].to_sym.should be :luna
    end
  end

  it "#post without target_screen_name" do
    VCR.use_cassette("tweet") do
      tweet = Tweet.new "clubmate"
      info = tweet.post
      info[:code].to_sym.should be :luna
    end
  end

  it "#to_s" do
    VCR.use_cassette("drinks") do
      tweet = Tweet.new :clubmate, "BakeRolls"
      tweet.to_s.should == "Ich trinke gerade Club-Mate mit BakeRolls."
      tweet = Tweet.new :clubmate
      tweet.to_s.should == "Ich trinke gerade Club-Mate."
    end
  end
end
