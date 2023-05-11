class Public::UsersController < ApplicationController
  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
    # DMを作るための構文
    @current_mini_entry = MiniEntry.where(user_id: current_user.id)
    @another_mini_entry = MiniEntry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_mini_entry.each do |current|
        @another_mini_entry.each do |another|
          if current.mini_room_id == another.mini_room_id
            @is_mini_room = true
            @mini_room_id = current.room_id
          end
        end
      end
      unless @is_mini_room
        @mini_room = MiniRoom.new
        @mini_entry = MiniEntry.new
      end
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "変更の保存に成功しました。"
    else
      render edit_user_path
      flash.now[:alert] = "変更に失敗しました。"
    end
  end

  def confirm
    @user = current_user
  end

  def withdrawal
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。"
    redirect_to root_path
  end

  #お気に入り一覧
  def favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :is_deleted, :image)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
