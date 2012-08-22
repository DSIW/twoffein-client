require_relative "spec_helper"
include SpecHelper

describe Drinks do
  subject { Drinks.new }

  it "::get" do
    VCR.use_cassette("drinks") do
      kaffee = {
        :drink => "Kaffee",
        :key => "kaffee",
        :brand => "0"
      }
      drinks = Drinks.get
      drinks.length > 10
      drinks.first.should eq kaffee
    end
  end

  it "::all" do
    VCR.use_cassette("drinks") do
      kaffee = {
        :drink => "Kaffee",
        :key => "kaffee",
        :brand => "0"
      }
      drinks = Drinks.get
      drinks.length > 10
      drinks.first.should eq kaffee
    end
  end

  it "::names" do
    VCR.use_cassette("drinks") do
      names = Drinks.names
      names.should include "Kaffee"
      names.should_not include :kaffee
      names.should_not include false
    end
  end

  it "::keys" do
    VCR.use_cassette("drinks") do
      keys = Drinks.keys
      keys.should_not include "Kaffee"
      keys.should include :kaffee
      keys.should_not include false
    end
  end

  it "::brands" do
    VCR.use_cassette("drinks") do
      brands = Drinks.brands
      brands.should_not include "Kaffee"
      brands.should_not include :kaffee
      brands.should include false
    end
  end

  it "::find" do
    VCR.use_cassette("drinks") do
      kaffee = Drink.new("Kaffee", "kaffee", false)
      found  = Drinks.find("kaffee")
      found.should eq kaffee
      found  = Drinks.find(:kaffee)
      found.should eq kaffee
      found  = Drinks["kaffee"]
      found.should eq kaffee
      found  = Drinks[:kaffee]
      found.should eq kaffee
    end
  end

  it "::search" do
    VCR.use_cassette("drinks") do
      kaffee = Drink.new("Kaffee", "kaffee", false)
      found  = Drinks.search("kaff")
      found.should include kaffee
      found  = Drinks.search(:kaff)
      found.should include kaffee
      found  = Drinks.search(/kaff/i)
      found.should include kaffee
    end
  end

  it "#init with subset" do
    VCR.use_cassette("drinks") do
      kaffee   = Drink.new("Kaffee", "kaffee", false)
      clubmate = Drink.new("Club-Mate")
      drinks = Drinks.new(kaffee)
      drinks.all.should include kaffee
      drinks = Drinks.new([kaffee,clubmate])
      drinks.all.should include kaffee, clubmate
    end
  end

  it "#init without subset" do
    VCR.use_cassette("drinks") do
      drinks   = Drinks.new
      drinks.length.should be > 10
      kaffee   = Drink.new("Kaffee", "kaffee", false)
      drinks.all.should include kaffee
    end
  end

  it "#length" do
    VCR.use_cassette("drinks") do
      kaffee   = Drink.new("Kaffee", "kaffee", false)
      clubmate = Drink.new("Club-Mate")
      drinks = Drinks.new([kaffee,clubmate])
      drinks.length.should be 2
    end
  end

  it "#add" do
    VCR.use_cassette("drinks") do
      kaffee   = Drink.new("Kaffee", "kaffee", false)
      clubmate = Drink.new("Club-Mate")
      drinks = Drinks.new([kaffee])
      drinks.add(clubmate)
      drinks.all.should include kaffee, clubmate
    end
  end

  it "#to_s" do
    VCR.use_cassette("drinks") do
      kaffee     = Drink.new("Kaffee", "kaffee", false)
      clubmate   = Drink.new("Club-Mate", "clubmate")
      test       = Drink.new("testtetetetsetestset", "test")
      drinks     = Drinks.new([kaffee,clubmate,test])
      drinks.length.should be 3
      kaffee_s   = "Kaffee                (kaffee)"
      clubmate_s = "Club-Mate             (clubmate)"
      test_s     = "testtetetetsetestset  (test)"
      drinks.to_s.should eq [kaffee_s, clubmate_s, test_s].join("\n")
    end
  end
end
