class ImportedUser < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true, uniqueness: true
  scope :not_aggregated, -> { where(aggregate_following_users_on: nil).first }
  GET_USER_NUM_FROM_TWITTER = 70
  SEARCH_WORD_IN_TWITTER = '駆け出しエンジニア'.freeze

  def self.import_users
    users = []
    twitter_rest_client.search(SEARCH_WORD_IN_TWITTER, count: GET_USER_NUM_FROM_TWITTER).take(GET_USER_NUM_FROM_TWITTER).each do |tweet|
      users << ImportedUser.new(twitter_id: tweet.user.id.to_s)
    end
    ImportedUser.import! users, on_duplicate_key_ignore: true
  end
end
