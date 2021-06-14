class RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    @user = User.find(params[:relationship][:followed_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    @user = current_user
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    @user = current_user
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
