class PointRecord < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true
  validates :points, presence: true
  validates :recorded_on, presence: true
  validates :twitter_id, uniqueness: { scope: :recorded_on }
  belongs_to :followed_user, foreign_key: 'twitter_id', primary_key: 'twitter_id'

  def self.aggregate_follow_users!
    imported_user = ImportedUser.where(aggregate_following_users_on: nil).first
    return unless imported_user

    following_ids = FollowedUser.pluck(:twitter_id)
    new_point_records = []
    new_followed_users = []
    twitter_rest_client.friend_ids(imported_user.twitter_id.to_i).attrs[:ids].first(Settings.aggregate_param.get_follow_user_num).each do |following_id|
      unless following_ids.include?(following_id.to_s)
        new_followed_users << FollowedUser.new(twitter_id: following_id.to_s)
      end
      new_point_records << PointRecord.new(twitter_id: following_id.to_s, points: 1, recorded_on: Date.today)
    end
    FollowedUser.import! new_followed_users, on_duplicate_key_ignore: true
    PointRecord.import! new_point_records, on_duplicate_key_update: 'points = points + 1'
    ImportedUser.find_by!(twitter_id: imported_user.twitter_id).update(aggregate_following_users_on: Date.today)
  end
end
