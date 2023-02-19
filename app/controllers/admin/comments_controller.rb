class Admin::CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to admin_comments_path
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
