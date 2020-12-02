class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:user_id])
    @friendship = Friendship.new(user: current_user, friend: @friend)
    @friendship.save!
    redirect_to friends_path
  end

  def friendship_decline
    @friendship = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    @friendship.update(confirmed: false)


    redirect_to friends_path
  end

  def friendship_confirm
    @friendship = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    @friendship.update(confirmed: true)


    redirect_to friends_path
  end

end
