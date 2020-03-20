require './app/models/concerns/twitter_rest_client'

class ImportedUser < ApplicationRecord
  extend TwitterRestClient

  def self.import_users
    twitter = twitter_rest_client
    twitter.search(Settings.get_user_param.word, count: Settings.get_user_param.num).take(Settings.get_user_param.num).each do |tweet|
      ImportedUser.find_or_create_by(twitter_id: tweet.user.id.to_s) do |user|
        user.registered_on = Date.today
      end
    end
  end
end
