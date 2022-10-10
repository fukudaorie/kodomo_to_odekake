class Public::SpotsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    @spot.user = current_user
    tag_list = params[:spot][:tag_ids]
    if @spot.save
      @spot.save_tag(tag_list)
      redirect_to spot_path(@spot),notice:'投稿完了しました'
    else
      render:new
    end
  end

  def index
    # first_expression = false

    # @spots = Spot.left_joins(:tags).all #for or
    # if params[:keyword].present? || (params[:tag_ids] && params[:tag_ids].values.include?("1"))
    #   if params[:keyword]
    #     split_keywords = params[:keyword].split(/[[:blank:]]+/)
    #     split_keywords.each do |keyword|
    #       if first_expression == false
    #         first_expression = true
    #         @spots = @spots.where("spots.name LIKE '%#{keyword}%' OR spots.address LIKE '%#{keyword}%'")
    #       else
    #         @spots = @spots.or(Spot.where("spots.name LIKE '%#{keyword}%' OR spots.address LIKE '%#{keyword}%'"))
    #       end
    #     end
    #   end

    #   params[:tag_ids].each do |key, value|
    #     @spots = @spots.where(tags: {id: key}) if value == "1"
    #   end
    # end
    # @spots = @spots.order('spots.id DESC').page(params[:page]).per(10)

    @spots = Spot.all.order('id DESC').page(params[:page]).per(10)
    if params[:keyword].present? || (params[:tag_ids] && params[:tag_ids].values.include?("1"))

      filtered_spots = []
      if params[:keyword].present?
        split_keywords = params[:keyword].split(/[[:blank:]]+/)
        split_keywords.each do |keyword|
          filtered_spots << Spot.where(['name LIKE(?) OR address LIKE(?)', "%#{keyword}%", "%#{keyword}%"])
        end
        filtered_spots.flatten!
        filtered_spots_ids = filtered_spots.map { |spot| spot.id }
        @spots = Spot.where(id: filtered_spots_ids).order('id DESC').page(params[:page]).per(10)
      else
        filtered_spots = Spot.all.order('id DESC').page(params[:page]).per(10)
      end
      check_filtered_spots = []
      if params[:tag_ids].values.include?("1")
        check_lists = []
        params[:tag_ids].each do |key, value|
          check_lists << key if value == "1"
        end
        filtered_spots.each do |spot|
          spot.tags.each do |tag|
            check_filtered_spots << spot if Tag.where(id: check_lists).pluck(:name).include?(tag.name)
          end
        end
        check_filtered_spots.flatten!
        check_filtered_spots_ids = check_filtered_spots.map { |spot| spot.id }
        @spots = Spot.where(id: check_filtered_spots_ids).order('id DESC').page(params[:page]).per(10)
        # @spots = Spot.where(id: SpotTagRelation.where(tag_id: check_lists).pluck(:spot_id)).order('id DESC').page(params[:page]).per(10)
      end
    end
  end

  def show
    @user = current_user
    @spot = Spot.find(params[:id])
    results = Geocoder.search(@spot.address)
    if results.any?
      @latlng = results.first.coordinates
    else
      @latlng = []
    end
    @post = Post.new
  end

  def edit
    @spot = Spot.find(params[:id])
    if @spot.user == User.guest
      redirect_to spots_path
    else
      if @spot.user == current_user
        render "edit"
      else
        redirect_to spots_path
      end
    end
  end

  def update
    @spot = Spot.find(params[:id])
    @spot.user = current_user
    tag_list = params[:spot][:tag_ids]
    if @spot.update(spot_params)
      @spot.save_tag(tag_list)
      redirect_to spot_path(@spot),notice:'編集完了しました'
    else
      render:edit
    end
  end

  def destroy
    @spot = Spot.find(params[:id])
    @spot.destroy
    redirect_to users_my_page_path, notice:'投稿を削除しました'
  end

  def map
    results = Geocoder.search(params[:address])
    #byebug

    if results.present?
      @latlng = results.first.coordinates
      # これでmap.js.erbで、経度緯度情報が入った@latlngを使える。
      @err_msg = "住所を取得出来ました。"
    else
      @latlng = []
      @err_msg = "住所を取得出来ませんでした。"
    end

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
    params.require(:spot).permit(:image, :name, :address, :keyword)
  end
end
