class Public::SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.save
    redirect_to public_spot_path(@spot)
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def spot_params
    params.require(:spot).permit(:image, :name, :address, :genre_id)
  end
end
