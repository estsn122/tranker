class PointRecord < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true
  validates :points, presence: true
  validates :recorded_on, presence: true
  validates :twitter_id, uniqueness: { scope: :recorded_on }

  def self.aggregate_follow_user
    twitter_id = ImportedUser.where(registered_on: nil).first.twitter_id
    return unless twitter_id

    logs = []
    twitter_rest_client.friend_ids(twitter_id.to_i).attrs[:ids].first(Settings.aggregate_param.get_follow_user_num).each do |following_id|
      logs << PointRecord.new(twitter_id: following_id, points: 1, recorded_on: Date.today)
    end
    PointRecord.import logs, on_duplicate_key_update: 'points = points + 1'
    ImportedUser.find_by(twitter_id: twitter_id).update(registered_on: Date.today)
  end
end
