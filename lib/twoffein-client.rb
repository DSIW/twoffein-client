require "twoffein-client/version"
require "twoffein-client/credentials"

require 'json'
require 'net/http'
require 'uri'

module Twoffein
  SCREEN_NAME = ENV['TWOFFEIN_SCREEN_NAME']
  API_KEY     = ENV['TWOFFEIN_API_KEY']
  BASE_URL    = 'http://twoffein.de/api/'
  PARAMS = {
    :screen_name => SCREEN_NAME,
    :api_key => API_KEY
  }

  class Error < StandardError
    attr_reader :type, :message
    def initialize(type, message)
      @type = type
      @message = message
    end
  end

  class HTTP
    def self.create_url(path, params={})
      query = URI.encode_www_form(params)
      # TODO: Change API-URI: Add controller in MVC
      URI.join(BASE_URL, path+'/').to_s + '?' + query
    end

    def self.fetch(uri_str, limit = 10)
      # You should choose a better exception.
      raise ArgumentError, 'too many HTTP redirects' if limit == 0

      response = Net::HTTP.get_response(URI(uri_str))

      case response
      when Net::HTTPSuccess then
        response
      when Net::HTTPRedirection then
        location = response['location']
        #warn "redirected to #{location}"
        fetch(location, limit - 1)
      else
        response.value
      end
    end

    def self.request(verb, path, params={})
      Util.compact! params
      case verb
      when :get
        res = fetch(create_url([verb, path].join('/'), PARAMS.merge(params)))
      when :post # TODO
        res = fetch(create_url([:post, path].join('/'), PARAMS.merge(params)))
      end
      JSON.parse(res.body, :symbolize_names => true)
    end

    def self.post_data(path, data, params={})
      #self.request(:post, path, params)
      uri = URI(path)
      req = Net::HTTP::Post.new(uri.path)
      req.set_form_data(data)
      #req.body = multipart_data
      #req.content_type = 'multipart/form-data'

      res = Net::HTTP.start(uri.hostname, uri.port) do |http|
        http.request(req)
      end

      case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        # OK
      else
        raise res.value
      end
    end

    def self.get(path, params={})
      request(:get, path, params)
    end

    def self.post(path, params={})
      request(:post, path, params)
    end
  end

  class Util
    def self.format(obj)
      sprintf("%-30.30s", obj)
    end

    def self.compact!(hash)
      hash.reject! { |k,v| v.nil? || v.empty? }
    end
  end

  class Drink
    attr_reader :name, :key, :brand

    def initialize(name, key=nil, brand=true)
      @name = name
      @key = key ? key : name.downcase
      @brand = brand
    end

    def self.get(name)
      HTTP.get("drinks", :drink => name)
    end

    def to_s
      "#@name  (#@key)"
    end
  end

  class Drinks
    attr_reader :all

    def initialize(subset=nil)
      unless subset
      @all ||= Drink.get("list")
        return @all.map! { |drink| Drink.new(drink[:drink], drink[:key], drink[:brand]) }
    end

      if subset.is_a? Array
        @all = subset
      else
        @all = [subset]
      end
    end

    class << self
      def all;    new.all;                 end
      def names;  all.map { |d| d.name  }; end
      def keys;   all.map { |d| d.key   }; end
      def brands; all.map { |d| d.brand }; end

      def find(key)
        all.each { |d| return d if d.key == key }
        nil
      end
      alias :[] :find

      def search search
        selected = all.select { |drink| drink.to_s =~ search }
        #all.grep(search) # TODO see :===
        new(selected).to_s
      end
    end

    def add(drink)
      raise ArgumentError, "drink has to be of type Drink" unless drink.is_a? Drink
      @all << drink
    end
    alias :<< :add

    def to_s
      max_length = self.class.names.map{ |d| d.length }.max
      @all.map do |d|
        name = d.name
        key = d.key
        "#{name.ljust(max_length+1)}(#{key})"
      end.join("\n")
    end
  end

  class Profile
    attr_reader :quest,
      :drink,
      :rank,
      :rank_title,
      :drunken,
      :bluttwoffeinkonzentration,
      :first_login,
      :screen_name

    def initialize(hash)
      @quest                     = hash[:quest]
      @drink                     = hash[:drink]
      @rank                      = hash[:rank]
      @rank_title                = hash[:rank_title]
      @drunken                   = hash[:drunken]
      @bluttwoffeinkonzentration = hash[:bluttwoffeinkonzentration]
      @first_login               = hash[:first_login]
      @screen_name               = hash[:screen_name]
    end

    def self.get(profile="")
      Profile.new(HTTP.get "profile", :profile => profile)
    end

    def to_s
      hash = instance_hash
      max_length = hash.keys.map { |k| k[1..-1].length }.max

      hash.map { |attr, value|
        attr = attr[1..-1].to_sym

        if attr == :first_login
          value = Time.at(value.to_i).strftime("%Y-%m-%d %H:%M")
        end

        "#{attr.to_s.ljust(max_length+1)}#{value}"
      }.join("\n")
    end

    private

    def instance_hash
      instance_variables.reduce({}) do |hash, ivar|
        hash.merge({ivar.to_sym => instance_variable_get(ivar)})
      end
    end
  end

  class Tweet
    attr_accessor :drink,
      :target_screen_name

    def initialize drink_key, target_screen_name=nil
      @drink = drink_key
      @target_screen_name = target_screen_name
    end

    def post
      info = HTTP.post("tweet", :drink => @drink, :target_screen_name => @target_screen_name)
      raise Error.new(info[:code], info[:error]) if info.has_key? :error
      info
    end
    alias publish post

    def to_s
      s = "Ich trinke gerade #{Drinks[@drink].name}"
      s << " mit #{@target_screen_name}" if @target_screen_name
      s << "."
    end
  end

  class Cookie
    attr_accessor :target_screen_name

    def initialize target_screen_name=nil
      @target_screen_name = target_screen_name
    end

    def post
      info =  HTTP.post("cookie", :target_screen_name => @target_screen_name)
      raise Error.new(info[:code], info[:error]) if info.has_key? :error
      info
    end
    alias send post

    def to_s
      "Ich gebe #@target_screen_name einen Keks!"
    end
  end
end
