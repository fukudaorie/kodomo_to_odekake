class Admin::SpotsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @spots = Spot.page(params[:page]).per(10)
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    flash[:notice] = "スポットが削除されました。"
    redirect_to admin_spots_path
  end
end
