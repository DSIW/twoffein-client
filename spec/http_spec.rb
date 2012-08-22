require_relative "spec_helper"
include SpecHelper

describe HTTP do
  it "#create_url" do
    url = "http://twoffein.com/api/get/drinks/?screen_name=#{SCREEN_NAME}&api_key=#{API_KEY}&encode=xml"
    HTTP.create_url("get/drinks", PARAMS.merge(:encode => :xml)).should eq url
  end

  it "#request without parameter" do
    VCR.use_cassette('drinks') do
      drinks = HTTP.request(:get, "drinks")
      drinks.length.should be > 10
      drink = drinks.first
      drink.should include(:drink, :key, :brand)
    end
  end

  it "#request as XML" do
    pending("XML isn't implemented.")
    VCR.use_cassette('drinks') do
      drinks = HTTP.request(:get, "drinks", :encode => :xml)
      drinks.should be_a_kind_of Array
      drinks.length.should be > 10
      drink = drinks.first
      drink.should be_a_kind_of Hash
      drink.should include(:drink, :key, :brand)
    end
  end

  it "#fetch drinks" do
    VCR.use_cassette('drinks') do
      url = "http://twoffein.de/api/get/drinks/?screen_name=#{SCREEN_NAME}&api_key=#{API_KEY}"
      response = HTTP.fetch(url)
      example_content = '[{"drink":"Kaffee","key":"kaffee","brand":"0"}'
      response.body.should include(example_content)
    end
  end

  it "#post_data" do
    pending("Not required by API")
  end

  it "#get" do
    VCR.use_cassette('drinks') do
      drinks = HTTP.get("drinks")
      drinks.should be_a_kind_of Array
      drinks.length.should be > 10
      drink = drinks.first
      drink.should be_a_kind_of Hash
      drink.should include(:drink, :key, :brand)
    end
  end

  it "#get as XML" do
    pending("XML isn't implemented.")
    VCR.use_cassette('drinks') do
      drinks = HTTP.get("drinks", :encode => :xml)
      drinks.should be_a_kind_of Array
      drinks.length.should be > 10
      drink = drinks.first
      drink.should be_a_kind_of Hash
      drink.should include(:drink, :key, :brand)
    end
  end

  it "#post" do
    pending("Not required by API")
  end

  it "#content_type" do
    VCR.use_cassette('drinks') do
      url = "http://twoffein.de/api/get/drinks/?screen_name=#{SCREEN_NAME}&api_key=#{API_KEY}"
      res = HTTP.fetch(url)
      HTTP.content_type(res).should match /application/
    end
  end

  it "#xml?" do
    VCR.use_cassette('drinks') do
      url = "http://twoffein.de/api/get/drinks/?screen_name=#{SCREEN_NAME}&api_key=#{API_KEY}&encode=xml"
      res = HTTP.fetch(url)
      HTTP.xml?(res).should be_true
    end
  end

  it "#json?" do
    VCR.use_cassette('drinks') do
      url = "http://twoffein.de/api/get/drinks/?screen_name=#{SCREEN_NAME}&api_key=#{API_KEY}"
      res = HTTP.fetch(url)
      HTTP.json?(res).should be_true
    end
  end
end
