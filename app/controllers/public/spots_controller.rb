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
    if params[:keyword] || (params[:tag_ids] && params[:tag_ids].values.include?("1"))

      filtered_spots = []
      if params[:keyword]
        split_keywords = params[:keyword].split(/[[:blank:]]+/)
        split_keywords.each do |keyword|
          filtered_spots << Spot.where(['name LIKE(?) OR address LIKE(?)', "%#{keyword}%", "%#{keyword}%"])
        end
        filtered_spots.flatten!
      else
        filtered_spots = Spot.all
      end
      check_filtered_spots = []
      if params[:tag_ids].values.include?("1")
        check_lists = []
        params[:tag_ids].each do |key, value|
          check_lists << key if value == "1"
        end
        filtered_spots.each do |spot|
          spot.tags.each do |tag|
            check_filtered_spots << spot if check_lists.include?(tag.name)
          end
        end
        @spots = check_filtered_spots.uniq
      else
        @spots = filtered_spots
      end
    end

  end

  def show
    @spot = Spot.find(params[:id])
    @post = Post.new
  end

  def destroy
    @spot =Spot.find(params[:id])
    @spot.destroy
    redirect_to public_spots_path
  end

  def map
    results = Geocoder.search(params[:address])
    @latlng = results.first.coordinates

    results = Geocoder.search("東京タワー")
    @latlng2 = results.first.coordinates
    # これでmap.js.erbで、経度緯度情報が入った@latlngを使える。
    # respond_to以下の記述によって、
    # remote: trueのアクセスに対して、
    # map.js.erbが変えるようになります。
    @target_address = params[:address]
    respond_to do |format|
      format.js
    end
  end


  private

  def spot_params
    params.require(:spot).permit(:image, :name, :address)
  end
end
