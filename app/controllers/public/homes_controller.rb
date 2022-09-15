class Public::HomesController < ApplicationController
  def top
    first_expression = false

    @spots = Spot.left_joins(:tags).all #for or
    if params[:keyword].present? || (params[:tag_ids] && params[:tag_ids].values.include?("1"))
      if params[:keyword]
        split_keywords = params[:keyword].split(/[[:blank:]]+/)
        split_keywords.each do |keyword|
          if first_expression == false
            first_expression = true
            @spots = @spots.where("spots.name LIKE '%#{keyword}%' OR spots.address LIKE '%#{keyword}%'")
          else
            @spots = @spots.or(Spot.where("spots.name LIKE '%#{keyword}%' OR spots.address LIKE '%#{keyword}%'"))
          end
        end
      end

      params[:tag_ids].each do |key, value|
        @spots = @spots.where(tags: {id: key}) if value == "1"
      end
    end
    @spots = @spots.order('spots.id DESC').page(params[:page]).per(6)
  end 
end
