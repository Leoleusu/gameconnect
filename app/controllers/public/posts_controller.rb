class Public::PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "投稿しました。"
      redirect_to public_posts_path
    else
      @user = current_user
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "変更に成功しました。"
      redirect_to public_posts_path
    else
      flash.now[:alert] = "変更に失敗しました。"
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "削除に成功しました。"
    redirect_to public_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:body,:user_id)
  end

end
