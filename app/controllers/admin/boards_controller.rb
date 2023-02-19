class Admin::BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find(params[:id])
  end

  def destroy
    board = Board.find(params[:id])
    if board.destroy
      flash[:notice] = "削除しました。"
      redirect_to admin_boards_path
    else
      flash[:alert] = "削除に失敗しました。"
      render :show
    end
  end

  private
    def board_params
      params.require(:board).permit(:title, :body)
    end
end
