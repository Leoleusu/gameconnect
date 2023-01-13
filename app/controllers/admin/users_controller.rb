class Admin::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
      flash[:notice] = "変更の保存に成功しました。"
    else
      render admin_user_path
      flash.now[:alert] = "変更に失敗しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:introduction,:is_deleted)
  end

end