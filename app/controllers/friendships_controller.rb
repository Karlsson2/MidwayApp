class FriendshipsController < ApplicationController
  def create
    @friend = User.find(params[:user_id])
    @friendship = Friendship.new(user: current_user, friend: @friend)
    @friendship.save!
    redirect_to friends_path
  end

end
