class Admin::BoardCommentsController < ApplicationController

  def index
    @board_comments = BoardComment.all
  end

  def show
    @board_comment = BoardComment.find(params[:id])
  end

  def destroy
    bc = BoardComment.find(params[:id])
    if bc.destroy
      flash[:notice] = "削除しました。"
      redirect_to admin_board_comments_path
    else
      flash.now[:alert] = "削除に失敗しました。"
      render :show
    end
  end

  private

  def board_comment_params
    params.require(:board_comment).permit(:body)
  end
end

