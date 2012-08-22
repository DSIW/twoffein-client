# encoding: utf-8
require_relative "spec_helper"
include SpecHelper

describe Drink do
  context "with default values" do
    subject { Drink.new("Test") }

    it "should get some variables" do
      subject.name.should == "Test"
      subject.key.should == :test
      subject.brand.should be_false
    end

    it "#to_s" do
      subject.to_s.should eq "Test  (test)"
    end
  end

  context "with explicit values" do
    subject { Drink.new("Test", "key", true) }

    it "should be initialized" do
      subject.name.should == "Test"
      subject.key.should == :key
      subject.brand.should be_true
    end

    it "should be initialized with special chars" do
      drink = Drink.new("Club-Mate")
      drink.name.should == "Club-Mate"
      drink.key.should == :clubmate
      drink.brand.should be_false

      drink = Drink.new("Ärzte")
      drink.name.should == "Ärzte"
      drink.key.should == :aerzte
      drink.brand.should be_false
    end

    it "#to_s" do
      subject.to_s.should eq "Test  (key)"
    end

    it "#==" do
      subject.should eq Drink.new("Test", "key", true)
    end
  end
end
