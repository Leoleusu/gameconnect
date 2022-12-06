class Public::FavoritesController < ApplicationController

  def create
    @favorite = Favorite.new
    @favorite.user_id = current_user
    @favorite.post_id = Post.find(params[:id])
    @favorite.save
    flash[:notice] = "いいね！"
    redirect_to public_post_path(post_id)
  end

  def destroy
  end
end
