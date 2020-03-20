class ImportedUser < ApplicationRecord
  include TwitterRestClient

  def self.import_users
    twitter_rest_client.search(Settings.get_user_param.word, count: Settings.get_user_param.num).take(Settings.get_user_param.num).each do |tweet|
      ImportedUser.find_or_create_by(twitter_id: tweet.user.id.to_s)
    end
  end
end
