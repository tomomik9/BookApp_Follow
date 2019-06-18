class FollowersController < ApplicationController
  before_action :authenticate_user!

  def show 
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
end
