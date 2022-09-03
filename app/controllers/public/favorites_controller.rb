class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
    @favorite = current_user.favorites.new(user_id: current_user.id, spot_id: params[:spot_id])
    @favorite.save
    redirect_to public_spot_path(params[:spot_id])
  end

  def destroy
    @favorite = current_user.favorites.find_by(spot_id: params[:spot_id])
    @favorite.destroy
    redirect_to public_spot_path(params[:spot_id])
  end

end
