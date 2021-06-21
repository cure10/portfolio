class UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = current_user
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully!"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def calender
    @user = User.find(params[:user_id])
    @events = Event.where(user_id: @user.id)
    @event = Event.new
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    unless params[:id].to_i == current_user.id
    redirect_to user_path(current_user)
    end
  end
end