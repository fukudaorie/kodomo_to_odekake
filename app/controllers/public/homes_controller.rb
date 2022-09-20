class Public::HomesController < ApplicationController
  def top
     @spots = Spot.all.order('id DESC').page(params[:page]).per(6)
    if params[:keyword].present? || (params[:tag_ids] && params[:tag_ids].values.include?("1"))

      filtered_spots = []
      if params[:keyword].present?
        split_keywords = params[:keyword].split(/[[:blank:]]+/)
        split_keywords.each do |keyword|
          filtered_spots << Spot.where(['name LIKE(?) OR address LIKE(?)', "%#{keyword}%", "%#{keyword}%"])
        end
        filtered_spots.flatten!
        filtered_spots_ids = filtered_spots.map { |spot| spot.id }
        @spots = Spot.where(id: filtered_spots_ids).order('id DESC').page(params[:page]).per(6)
      else
        filtered_spots = Spot.all.order('id DESC').page(params[:page]).per(6)
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
        @spots = Spot.where(id: check_filtered_spots_ids).order('id DESC').page(params[:page]).per(6)
      end
    end
  end
end
