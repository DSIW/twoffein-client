require_relative "spec_helper"
include SpecHelper

describe Util do
  it "::compact!" do
    hash = {
      :zero => "ok",
      :first => nil,
      :second => "",
      :third => '',
      :test => :test,
    }
    Util.compact!(hash)
    compacted = {
      :zero => "ok",
      :test => :test,
    }
    hash.should == compacted
  end
end
