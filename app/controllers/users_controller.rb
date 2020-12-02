class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id)
  end

  def friends
    @friends = friends_of_user_contr
    @not_friends = current_user.not_friends_of_user
    @search = params["search"]
    if params["search"].present?
      @name = @search["name"]
      @not_friends = @not_friends.search_by_username_and_first_name_and_last_name(@name)
    else
      @not_friends = current_user.not_friends_of_user
    end
    @recieved_requests = recieved_requests
    @sent_requests = sent_requests
  end

  private

  def sent_requests
    pending = []
    current_user.friends.each do |friendship|
      if current_user.id == friendship.user_id && friendship.confirmed.nil?
        pending << User.find(friendship.friend_id)
    end
  end
  pending
end

  def recieved_requests
    pending = []
    current_user.friends.each do |friendship|
      if current_user.id == friendship.friend_id && friendship.confirmed.nil?
        pending << User.find(friendship.user_id)
    end
  end
  pending
end

  def friends_of_user_contr
    friends = []

    current_user.friends.each do |friendship|
      if current_user.id == friendship.user_id && friendship.confirmed == true;
        friends << User.find(friendship.friend_id)
      elsif current_user.id == friendship.friend_id && friendship.confirmed == true;
        friends << User.find(friendship.user_id)
      end
  end
  friends
end
end
