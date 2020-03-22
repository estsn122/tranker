class FollowedUser < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true, uniqueness: true
  validates :truncation, inclusion: [true, false]

  # truncationがfalseなuserのフォロワー数を確認し、足切りリストに入れる
  def self.truncate_by_follower
    scan_ids = FollowedUser.where(truncation: false).order(updated_at: 'asc').first(Settings.truncate_param.lookup_max_num).map { |n| n.twitter_id.to_i }
    update_sql = []
    twitter_rest_client.users(scan_ids).each do |scan_user|
      update_sql << if scan_user.followers_count < Settings.truncate_param.truncate_criteria
                      FollowedUser.new(twitter_id: scan_user.id, truncation: true, updated_at: DateTime.now)
                    else
                      FollowedUser.new(twitter_id: scan_user.id, truncation: false, updated_at: DateTime.now)
                    end
    end

    FollowedUser.import update_sql, on_duplicate_key_update: %i[truncation updated_at]
  end

  def self.import_followed_users(import_ids)
    imported_ids = FollowedUser.select(:twitter_id).map { |n| n.twitter_id.to_i }
    import_sql = []
    (import_ids - imported_ids).each do |following|
      import_sql << FollowedUser.new(twitter_id: following.to_s, truncation: 'false')
    end
    FollowedUser.import import_sql, on_duplicate_key_update: [:updated_at]
  end
end
