class ImportedUser < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true, uniqueness: true

  def self.import_users
    import_users = []
    twitter_rest_client.search(Settings.get_user_param.word, count: Settings.get_user_param.num).take(Settings.get_user_param.num).each do |tweet|
      import_users << ImportedUser.new(twitter_id: tweet.user.id.to_s)
    end
    ImportedUser.import import_users, on_duplicate_key_ignore: true
  end
end
