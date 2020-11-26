class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
  end

  def friends
    @friends = current_user.friends
    @not_friends = current_user.not_friends_of_user
    @search = params["search"]
    if params["search"].present?
      @name = @search["name"]
      @not_friends = @not_friends.search_by_username_and_first_name_and_last_name(@name)
    else
      @not_friends = current_user.not_friends_of_user
    end
  end
end
