class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "変更に成功しました。"
      redirect_to admin_post_path(@post)
    else
      flash.now[:alert] = "変更に失敗しました。"
      render :show
    end
  end

  def destroy
    post = Post.find(params[:id])
    if post.destroy
      flash[:notice] = "削除しました。"
      redirect_to admin_posts_path
    else
      render :show
      flash.now[:alert] = "削除に失敗しました。"
    end
  end

  private

  def post_params
    params.require(:post).permit(:body,:user_id)
  end
end
