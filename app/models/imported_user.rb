class ImportedUser < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true, uniqueness: true

  def self.import_users
    users = []
    twitter_rest_client.search(Settings.get_user_param.word, count: Settings.get_user_param.num).take(Settings.get_user_param.num).each do |tweet|
      users << ImportedUser.new(twitter_id: tweet.user.id.to_s)
    end
    ImportedUser.import! users, on_duplicate_key_ignore: true
  end
end
