class FollowsController < ApplicationController 
  before_action :authenticate_user!

  def show
    @user  = User.find(params[:id])
    @users = @user.following
    render 'show_follow'
  end
end
