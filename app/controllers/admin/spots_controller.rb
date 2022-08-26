class Admin::SpotsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @spots = @user.spot
  end
end
