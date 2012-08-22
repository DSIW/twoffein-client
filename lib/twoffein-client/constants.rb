module Twoffein
  SCREEN_NAME = ENV['TWOFFEIN_SCREEN_NAME']
  API_KEY     = ENV['TWOFFEIN_API_KEY']
  BASE_URL    = 'http://twoffein.com/api/'
  PARAMS = {
    :screen_name => SCREEN_NAME,
    :api_key => API_KEY
  }
end
