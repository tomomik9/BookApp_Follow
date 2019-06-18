class FollowsController < ApplicationController 

  def show
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
end
