class UnregisteredUser < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true, uniqueness: true
  validates :truncation, inclusion: [true, false]

  # TODO: UnregisteredUserは後で名前変える
  # NOTE: ImportedUserは読み込むユーザーリスト
  # NOTE: UnregisteredUserはフォロー先ユーザーリスト

  # truncationがfalseなuserのフォロワー数を確認し、足切りリストに入れる
  def self.unregister_by_follower
    confirm_ids = UnregisteredUser.where(truncation: false).order(updated_at: 'asc').first(100).map { |n| n.twitter_id.to_i }
    list = []

    twitter_rest_client.users(confirm_ids).each do |user|
      if user.followers_count < 1000
        list << UnregisteredUser.new(twitter_id: user.id, truncation: true, updated_at: DateTime.now)
      else
        list << UnregisteredUser.new(twitter_id: user.id, truncation: false, updated_at: DateTime.now)
      end
    end

    UnregisteredUser.import list, on_duplicate_key_update: [:truncation, :updated_at]
  end

  def self.import_unregistered_user(ids1)
    ids2 = UnregisteredUser.where(truncation: false).select(:twitter_id).map { |n| n.twitter_id.to_i }
    import_sql = []
    (ids1 - ids2).each do |following|
      import_sql << UnregisteredUser.new(twitter_id: following.to_s, truncation: 'false')
    end
    UnregisteredUser.import import_sql, on_duplicate_key_update: [:updated_at]
  end

  # TODO (別クラスに実装)rankingとPointlogから、このクラスで登録しているユーザーを削除
  # def
  # end
end
