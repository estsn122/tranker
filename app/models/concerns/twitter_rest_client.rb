module TwitterRestClient
  extend ActiveSupport::Concern

  class_methods do
    def twitter_rest_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = Settings.twitter.consumer_key
        config.consumer_secret     = Settings.twitter.consumer_secret
        config.access_token        = Settings.twitter.access_token
        config.access_token_secret = Settings.twitter.access_token_secret
      end
    end
  end
end
