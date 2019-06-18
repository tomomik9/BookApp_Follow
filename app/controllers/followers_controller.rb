class FollowersController < ApplicationController
   def show 
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end
end
