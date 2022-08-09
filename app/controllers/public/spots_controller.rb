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
    redirect_to public_spots_path if params[:keyword] == ""
    split_keyword = params[:keyword].split(/[[:blank:]]+/)
    spots_ids = []
    split_keyword.each do |keyword|
      next if keyword == ""
      spots_ids += Spot.where(['name LIKE(?) OR address LIKE(?)', "%#{split_keyword}%", "%#{split_keyword}%"]).pluck('id')
    end
    if params[:tag_ids].present?
      params[:tag_ids].each do |key, value|
        spots_ids += Tag.find_by(name: key).spots.pluck('id') if value == "1"
      end
      spots_ids.uniq
      @spots.where!(id: spots_ids) if spots_ids.present?
    end

  end

  def show
    @spot = Spot.find(params[:id])
    @post = Post.new
  end

  def edit
  end


  private

  def spot_params
    params.require(:spot).permit(:image, :name, :address, :keyword)
  end
end
