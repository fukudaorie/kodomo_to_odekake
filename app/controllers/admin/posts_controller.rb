class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "レビューが削除されました。"
    redirect_to admin_posts_path
  end
end
