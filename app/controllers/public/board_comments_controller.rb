class Public::BoardCommentsController < ApplicationController
  def create
    board_comment = current_user.board_comments.build(board_comment_params)
    if board_comment.save
      redirect_to board_path(params[:board_id])
      flash[:notice] = "掲示板にコメントしました。"
    else
      redirect_to board_path(params[:board_id])
      flash[:alert] = "掲示板へのコメントに失敗しました。"
    end
  end

  private
    def board_comment_params
      params.require(:board_comment).permit(:body).merge(board_id: params[:board_id])
    end
end
