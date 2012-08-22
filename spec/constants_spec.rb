require_relative "spec_helper"
include SpecHelper

describe "Constants" do
  it "should exist" do
    SCREEN_NAME.should be
    API_KEY.should be
    BASE_URL.should match(/^http:\/\//)
    PARAMS.should include(:screen_name, :api_key)
  end
end
