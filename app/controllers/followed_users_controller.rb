class FollowedUsersController < ApplicationController
  def index
    ids = FollowedUser.joins(:point_records).group(:twitter_id).sum(:points).sort_by { |_, v| -v }.first(FollowedUser::LOWEST_RANK_TO_DISPLAY)
    @rankers = FollowedUser.where(twitter_id: ids.map { |id, _| id.to_i })
  end
end
