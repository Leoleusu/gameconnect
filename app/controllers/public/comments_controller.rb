class Public::CommentsController < ApplicationController
  def show
    @comment = Comment.find(params[:id])
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
