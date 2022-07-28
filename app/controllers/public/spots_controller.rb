class Public::SpotsController < ApplicationController
  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    tag_list = params[:spot][:tag_ids]
    if @spot.save
      @spot.save_tag(tag_list)
      redirect_to public_spot_path(@spot),notice:'投稿完了しました:)'
    else
      render:new
    end
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
    params.require(:spot).permit(:image, :name, :address, tag_ids:[])
  end
end
