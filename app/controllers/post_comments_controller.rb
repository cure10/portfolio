class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.post_comments.build(post_comment_params)
    comment.user_id = current_user.id
    comment.post_id = @post.id
    @post_comment_post = comment.post
    if comment.save
      @post_comment_post.create_notification_comment!(current_user, comment.id)
      redirect_to post_path(@post), notice: "コメント作成に成功しました！"
    else
      @post = Post.find(params[:post_id])
      @post_index = @post.post_comments.page(params[:page]).per(5)
      @user = @post.user
      @post_comment = PostComment.new
      flash.now[:alert] = "コメント作成に失敗しました！空白ではコメントできません！"
      render template: "posts/show"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(@post), notice: "コメント削除に成功しました！"
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
