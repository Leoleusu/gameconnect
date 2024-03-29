class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    #byebug
    comment.create_notification_comment(current_user)
    flash[:notice] = "コメントしました"
    redirect_to post_path(post.id)
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(coment_params)
      redirect_to comment_path(@comment)
      flash[:notice] = "編集しました。"
    else
      render :show
      flash.now[:alert] = "編集に失敗しました。"
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to post_path(post)
      flash[:notice] = "コメントを削除しました。"
    else
      render :show
      flash.now[:alert] = "コメントの削除に失敗しました。"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
