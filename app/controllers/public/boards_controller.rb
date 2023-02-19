class Public::BoardsController < ApplicationController
  def new
    @board = Board.new
  end

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
    @board_comment = BoardComment.new
    @board_comments = @board.board_comments.includes(:user).page(params[:page])
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      flash[:notice] = "新しい掲示板を作成しました。"
      redirect_to public_board_path(@board)
    else
      flash[:notice] = "掲示板の作成に失敗しました。"
      render :new
    end
  end

  private
    def board_params
      params.require(:board).permit(:title, :body)
    end
end
