class FollowedUser < ApplicationRecord
  include TwitterRestClient
  validates :twitter_id, presence: true, uniqueness: true
  validates :official_account, inclusion: [true, false]
  has_many :point_records, primary_key: 'twitter_id', foreign_key: 'twitter_id'
  LOWEST_RANK_TO_DISPLAY = 30

  def self.update_rankers_information
    ranker_ids = FollowedUser.joins(:point_records).group(:twitter_id).sum(:points).sort_by { |_, v| -v }.first(LOWEST_RANK_TO_DISPLAY).map { |n, _| n.to_i }
    return unless ranker_ids

    update_keys = %i[twitter_id followers_num name screen_name profile profile_image_url]
    update_values = []
    ranker_ids.each_slice(100) do |hundred_in_total_ranker|
      twitter_rest_client.users(hundred_in_total_ranker).each do |ranker|
        update_values << [ranker.id.to_s, ranker.followers_count, ranker.name.to_s, ranker.screen_name, ranker.description.to_s, ranker.profile_image_url_https.to_s]
      end
    end
    FollowedUser.import! update_keys, update_values, on_duplicate_key_update: %i[followers_num name screen_name profile profile_image_url]
  end

  def make_followed_button(screen_name)
    'https://twitter.com/' + screen_name + '?ref_src=twsrc%5Etfw'
  end
end
