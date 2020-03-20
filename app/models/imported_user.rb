require './app/models/concerns/twitter_rest_client'

class ImportedUser < ApplicationRecord
  extend TwitterRestClient

  def self.import_users
    twitter = twitter_rest_client
    twitter.search(Settings.get_user_param.word, count: Settings.get_user_param.num).take(Settings.get_user_param.num).each do |tweet|
      twitter_id = tweet.user.id.to_s
      unless ImportedUser.find_by(twitter_id: twitter_id)
        ImportedUser.create(twitter_id: twitter_id, registered_on: Date.today)
      end
    end
  end
end
