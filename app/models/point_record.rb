class PointRecord < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true
  validates :points, presence: true
  validates :recorded_on, presence: true
  validates :twitter_id, uniqueness: { scope: :recorded_on }
  belongs_to :followed_user, foreign_key: 'twitter_id', primary_key: 'twitter_id', optional: true
  NUM_TO_AGGREGATE_FOLLOWING = 3000

  def self.aggregate_follow_users
    imported_user = ImportedUser.where(aggregate_following_users_on: nil).first
    return unless imported_user

    new_point_records = []
    twitter_rest_client.friend_ids(imported_user.twitter_id.to_i).attrs[:ids].first(NUM_TO_AGGREGATE_FOLLOWING).each do |following_id|
      new_point_records << PointRecord.new(twitter_id: following_id, points: 1, recorded_on: Date.today)
    end
    PointRecord.import! new_point_records, on_duplicate_key_update: 'points = points + 1'
    ImportedUser.find_by!(twitter_id: imported_user.twitter_id).update(aggregate_following_users_on: Date.today)
  end
end
