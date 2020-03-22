class UnregisteredUser < ApplicationRecord
  validates :twitter_id, presence: true, uniqueness: true
end
