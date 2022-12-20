class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    post.create_notification_comment(current_user)
    flash[:notice] = "コメントしました"
    redirect_to public_post_path(post.id)
  end

  def edit

  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
