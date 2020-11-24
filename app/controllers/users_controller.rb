class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
  end

  def friends
    @friends = current_user.friends
    @not_friends = current_user.not_friends_of_user
  end
end
