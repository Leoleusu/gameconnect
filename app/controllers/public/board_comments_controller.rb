class Public::BoardCommentsController < ApplicationController

  def create
    board_comment = current_user.board_comments.build(board_comment_params)
    if board_comment.save(board_comment_params)
      redirect_to public_board_path(board_id)
      flash[:notice] = "掲示板にコメントしました。"
    else
      render :show
      flash[:alert] = "掲示板へのコメントに失敗しました。"
    end
  end

  private

  def board_comment_params
    params.require(:board_comment).permit(:body).merge(board_id: params[:board_id])
  end

end
