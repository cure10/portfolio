class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(15)
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
      redirect_to posts_path, notice: '投稿に成功しました！'
    else
      flash.now[:alert] = "投稿に失敗しました!必ず入力と選択をして下さい！"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_index = @post.post_comments.page(params[:page]).per(5)
    @user = @post.user
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: '投稿に成功しました！'
    else
      flash[:alert] = "編集に失敗しました！"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿の削除に成功しました！'
  end

  private

  def post_params
    params.require(:post).permit(:title, :title_comment, :title_image)
  end

end