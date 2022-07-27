class Public::SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    tag_list = params[:spot][:tag_ids].split(",") #追加
    @spot.tag_save(tag_list)
    redirect_to public_spot_path(@spot)
  end

  def index
  end

  def show
    @spot = Spot.find(params[:id])
  end

  def edit
  end

  private

  def spot_params
    params.require(:spot).permit(:image, :name, :address, tag_ids: [])
  end
end
