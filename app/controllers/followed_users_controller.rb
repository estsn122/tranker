class FollowedUsersController < ApplicationController
  def index
    @rankers = FollowedUser.order(total_points: 'desc').limit(FollowedUser::RANKERS_NUM_TO_DISPLAY)
  end
end
