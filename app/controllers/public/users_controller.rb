class Public::UsersController < ApplicationController
  before_action :set_user,only: [:favorites]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to public_user_path(@user)
      flash[:notice] = "変更の保存に成功しました。"
    else
      render edit_public_user_path
      flash.now[:alert] = "変更に失敗しました。"
    end
  end

  def confirm
    @user = current_user
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会しました。"
    redirect_to root_path
  end

  #お気に入り一覧
  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:user_id)
    @favorite_posts = Post.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:is_deleted)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
