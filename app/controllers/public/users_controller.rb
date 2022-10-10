class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def show
    @user = current_user
    @spots = @user.spots.order('id DESC').page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
    @children = @user.children
      if @user == current_user
        render "edit"
      else
        redirect_to users_my_page_path
      end
  end

  def update
    if current_user == User.guest
      redirect_to users_my_page_path, alert: 'ゲストユーザーの編集はできません。'
    elsif @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to users_my_page_path
    else
      render :edit
    end
  end

  def withdraw
    if current_user == User.guest
      redirect_to users_my_page_path, alert: 'ゲストユーザーの退会はできません。'
    else
      @user = current_user
      @user.update(is_delete: true)
      reset_session
      redirect_to root_path, notice: '退会しました。'
    end
  end

  def favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:spot_id)
    @favorite_spots = Spot.find(favorites)
  end

  private

  def user_params
     params.require(:user).permit(:nickname, :email, children_attributes: [:id, :sex, :birth_date,:_destroy])
  end
end
