class PointLog < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true
  validates :points, presence: true
  validates :aggregated_on, presence: true
  validates :twitter_id, uniqueness: { scope: :aggregated_on }

  def self.aggregate_follow_user
    imported_user_id = ImportedUser.where(registered_on: nil).first.twitter_id
    return unless imported_user_id

    target_ids = PointLog.target_following_ids(imported_user_id)
    return unless target_ids

    PointLog.calculate_result(target_ids)
    FollowedUser.import_followed_users(target_ids)
    ImportedUser.find_by(twitter_id: imported_user_id).update(registered_on: Date.today)
  end

  def self.target_following_ids(imported_user_id)
    # NOTE: 取得するユーザー数を絞っているのは負荷を減らすため。取得IDは小さい順や辞書順ではないため、それにより結果が偏ることはない。
    following_ids = twitter_rest_client.friend_ids(imported_user_id.to_i).attrs[:ids].first(Settings.aggregate_param.get_follow_user_num)
    truncation_ids = FollowedUser.where(truncation: true).map { |n| n.twitter_id.to_i }
    following_ids - truncation_ids
  end

  def self.calculate_result(target_ids)
    calculate_sql = []
    target_ids.each do |target_id|
      calculate_sql << PointLog.new(twitter_id: target_id.to_s, points: 1, aggregated_on: Date.today)
    end
    PointLog.import calculate_sql, on_duplicate_key_update: 'points = points + 1'
  end
end
