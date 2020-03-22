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
    tw = PointLog.truncate_by_follower_num(hairetu)

    if tw
      logs = []
      tw.each do |following|
        logs << PointLog.new(twitter_id: following.id.to_s, points: 1, aggregated_on: Date.today)
      end
      PointLog.import logs, on_duplicate_key_update: 'points = points + 1'
    end
    ImportedUser.find_by(twitter_id: twitter_id).update(registered_on: Date.today)
  end

  def self.truncate_by_follower_num(twitter_ids)
    twitter = twitter_rest_client
    list = []
    twitter_ids.each_slice(100).to_a.each do |follow_array|
      list << twitter.users(follow_array).select { |follow| follow.followers_count > 1000 }
    end
    list.delete(nil)
    list.flatten!
  end
end
