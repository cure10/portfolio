class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]
  def index
    @users = User.page(params[:page]).per(15)
    @user = current_user
  end

  def show
    @user = current_user
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
    userfollowed = User.find(params[:id])
    @usersfollowed = userfollowed.followings.page(params[:page]).per(5)
    userfollowerss = User.find(params[:id])
    @usersfollowerss = userfollowerss.followers.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '編集に成功しました'
    else
      flash.now[:alert] = "編集に失敗しました!"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user), alert: '権限がありません!'
    end
  end
end

