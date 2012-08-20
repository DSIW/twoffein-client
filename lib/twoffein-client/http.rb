require 'json'
require 'net/http'
require 'uri'

require_relative "http"
require_relative "util"

module Twoffein
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
end
