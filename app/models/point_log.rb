class PointLog < ApplicationRecord
  include TwitterRestClient

  def self.aggregate_follow_user
    twitter_id = ImportedUser.where(registered_on: nil).first.twitter_id
    return unless twitter_id

    logs = []
    twitter_rest_client.friend_ids(twitter_id.to_i).attrs[:ids].first(Settings.aggregate_param.get_follow_user_num).each do |following_id|
      logs << PointLog.new(twitter_id: following_id, points: 1, aggregated_on: Date.today)
    end
    PointLog.import logs, on_duplicate_key_update: 'points = points + 1'
    ImportedUser.find_by(twitter_id: twitter_id).update(registered_on: Date.today)
  end
end
