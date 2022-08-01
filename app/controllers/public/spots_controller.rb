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
    @spots = Spot.all
    if params[:tag_ids]
      @spots = []
      params[:tag_ids].each do |key, value|
        @spots += Tag.find_by(name: key).spots if value == "1"
      end
      @spots.uniq!
    end
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
