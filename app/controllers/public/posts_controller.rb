class Public::PostsController < ApplicationController
  def index
    @spot = Spot.find(params[:spot_id])
    @posts = @spot.posts
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
    params.require(:post).permit(:star, :comment, :created_at)
  end

end