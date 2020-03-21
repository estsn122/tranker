class Ranker < ApplicationRecord
  validates :twitter_id, presence: true, uniqueness: true
  validates :points, presence: true
  validates :official, inclusion: [true, false]

  def self.reflect_log; end
end