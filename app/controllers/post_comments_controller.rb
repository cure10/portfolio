class PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    comment = @post.post_comments.build(post_comment_params)
    comment.user_id = current_user.id
    comment.post_id = @post.id
    @post_comment_post = comment.post
    comment.save
    @post_comment_post.create_notification_comment!(current_user, comment.id)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to post_path(@post)
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
