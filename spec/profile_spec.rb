# encoding: utf-8
require_relative "spec_helper"
include SpecHelper

describe Profile do
  it "#init" do
    profile = Profile.new(:quest => "", :drink => "clubmate", :ranke => 1234, :rank_title => "title", :drunken => 123, :bluttwoffeinkonzentration => "high", :first_login => Time.now, :screen_name => SCREEN_NAME, :novalid => true)
    profile.members.count.should be 8
    expect { profile.novalid }.to raise_error
  end

  it "#init without values" do
    profile = Profile.new
    profile.members.count.should be 8
    profile.members.each do |member, val|
      val.should be_nil
    end
  end

  it "::get" do
    VCR.use_cassette("profile") do
      profile = Profile.get
      profile.quest.should eq "Blitzlicht"
      profile.drink.should eq "Club-Mate"
      profile.rank.should eq 74
      profile.rank_title.should eq "Kaffeekännchen"
      profile.drunken.should eq "15"
      profile.bluttwoffeinkonzentration.should eq "1%"
      profile.first_login.should eq "1341747375"
      profile.screen_name.should eq SCREEN_NAME
    end
  end

  it "::get with profile" do
    VCR.use_cassette("profile") do
      pending "Server has to implement"
      profile = Profile.get("BakeRolls")
    end
  end

  it "#to_s" do
    pending ""
    VCR.use_cassette("profile") do
      profile = Profile.get
      output = <<-EOF
Quest:                     Blitzlicht
Drink:                     Club-Mate
Rank:                      74
Rank Title:                Kaffeekännchen
Drunken:                   15
Bluttwoffeinkonzentration: 1%
First Login:               2012-07-08 13:36
Screen Name:               DSIW
      EOF
      profile.to_s.should eq output
    end
  end
end
