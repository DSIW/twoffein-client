require_relative "spec_helper"
include SpecHelper

describe Server::Error do
  subject { Server::Error.new :wrong, "Something went wrong." }
  it "#init" do
    subject.type.should eq :wrong
    subject.message.should eq "Something went wrong."
  end

  it "#to_s" do
    subject.to_s.should eq "wrong"
  end
end
