class Public::HomesController < ApplicationController
  def top
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


end
