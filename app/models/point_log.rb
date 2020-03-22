class PointLog < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true
  validates :points, presence: true
  validates :aggregated_on, presence: true
  validates :twitter_id, uniqueness: { scope: :aggregated_on }

  def self.aggregate_follow_user
    twitter_id = ImportedUser.where(registered_on: nil).first.twitter_id
    return unless twitter_id

    # NOTE: 取得するユーザー数を絞っているのは負荷を減らすため。取得IDは小さい順や辞書順ではないため、結果が偏ることはない。
    hairetu = twitter_rest_client.friend_ids(twitter_id.to_i).attrs[:ids].first(Settings.aggregate_param.get_follow_user_num)

    # 登録しないユーザーの分を取り除く
    unregister_ids = FollowedUser.where(truncation: true).map { |n| n.twitter_id.to_i }
    register_ids = hairetu - unregister_ids

    if register_ids
      register_sql = []
      register_ids.each do |following|
        register_sql << PointLog.new(twitter_id: following.to_s, points: 1, aggregated_on: Date.today)
      end
      PointLog.import register_sql, on_duplicate_key_update: 'points = points + 1'
      FollowedUser.import_unregistered_user(register_ids)
    end
    ImportedUser.find_by(twitter_id: twitter_id).update(registered_on: Date.today)
  end
end
