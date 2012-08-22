require_relative "../lib/twoffein-client"
require "vcr"

module SpecHelper
  VCR.configure do |c|
    c.cassette_library_dir = 'fixtures/vcr_cassettes'
    c.hook_into :webmock # or :fakeweb
    c.default_cassette_options = {
      :record => :new_episodes,
      :erb => true
    }

    c.register_request_matcher :ignore_query_param_ordering do |request1, request2|
      uri1 = URI(request1.uri)
      uri2 = URI(request2.uri)

      uri1.scheme == uri2.scheme &&
        uri1.host == uri2.host &&
        uri1.path == uri2.path &&
        CGI.parse(uri1.query) == CGI.parse(uri2.query)
    end
  end

  include Twoffein
end
