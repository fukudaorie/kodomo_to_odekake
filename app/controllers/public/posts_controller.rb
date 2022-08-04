class Public::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.spot_id = params[:spot_id]
    @post.user_id = current_user.id
    @post.save
    redirect_to public_spot_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:star, :comment)
  end

end
