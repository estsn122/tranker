class FollowedUsersController < ApplicationController
  def index
    @rankers = []
    ids = FollowedUser.joins(:point_records).group(:twitter_id).sum(:points).sort_by { |_, v| -v }.first(FollowedUser::LOWEST_RANK_TO_DISPLAY)
    ids.each do |id, _|
      @rankers << FollowedUser.find_by(twitter_id: id)
    end
    @rankers
  end
end
