class FollowedUser < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true, uniqueness: true
  validates :truncation, inclusion: [true, false]

  # truncationがfalseなuserのフォロワー数を確認し、足切りリストに入れる
  def self.unregister_by_follower
    confirm_ids = FollowedUser.where(truncation: false).order(updated_at: 'asc').first(100).map { |n| n.twitter_id.to_i }
    list = []

    twitter_rest_client.users(confirm_ids).each do |user|
      if user.followers_count < 1000
        list << FollowedUser.new(twitter_id: user.id, truncation: true, updated_at: DateTime.now)
      else
        list << FollowedUser.new(twitter_id: user.id, truncation: false, updated_at: DateTime.now)
      end
    end

    FollowedUser.import list, on_duplicate_key_update: [:truncation, :updated_at]
  end

  def self.import_unregistered_user(ids1)
    ids2 = FollowedUser.where(truncation: false).select(:twitter_id).map { |n| n.twitter_id.to_i }
    import_sql = []
    (ids1 - ids2).each do |following|
      import_sql << FollowedUser.new(twitter_id: following.to_s, truncation: 'false')
    end
    FollowedUser.import import_sql, on_duplicate_key_update: [:updated_at]
  end
end
