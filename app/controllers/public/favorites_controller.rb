class Public::FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.new(post_id: post.id)
    favorite.save
    post.create_notification_favorite(current_user, post.id, post.user_id)
    flash[:notice] = "いいね！"
    redirect_to public_post_path(post.id)
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find_by(post_id: post.id)
    favorite.destroy
    flash[:notice] = "やっぱりよくなかったね…"
    redirect_to public_post_path(post.id)
  end
end
