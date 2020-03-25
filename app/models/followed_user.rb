class FollowedUser < ApplicationRecord
  validates :twitter_id, presence: true, uniqueness: true
  validates :points, presence: true
  validates :official_account, inclusion: [true, false]

  def self.reflect_log; end
end
