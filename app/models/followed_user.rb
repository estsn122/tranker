class FollowedUser < ApplicationRecord
  validates :twitter_id, presence: true, uniqueness: true
  validates :official_account, inclusion: [true, false]
  has_many :point_records, primary_key: 'twitter_id', foreign_key: 'twitter_id'

  def self.reflect_log; end
end
