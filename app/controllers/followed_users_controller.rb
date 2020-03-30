class FollowedUsersController < ApplicationController
  def index
    @rankers = FollowedUser.order(total_points: 'desc').first(FollowedUser::LOWEST_RANK_TO_DISPLAY)
  end
end
