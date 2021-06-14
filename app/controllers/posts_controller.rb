class PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "successfully"
      redirect_to post_path(@post)
    else
      @user = current_user
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @user_profile = @post.user
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user
    if  @user == current_user
        render "edit"
    else
        redirect_to posts_path
    end
  end

  def  update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "successfully"
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :title_comment, :title_image)
  end
end

