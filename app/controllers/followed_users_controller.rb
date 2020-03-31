class FollowedUsersController < ApplicationController
  def index
    @rankers = FollowedUser.order(total_points: 'desc').first(FollowedUser::RANKERS_NUM_TO_DISPLAY)
  end
end
