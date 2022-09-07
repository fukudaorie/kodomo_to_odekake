class Public::UsersController < ApplicationController
  def show
    @user = current_user
    @spots = @user.spots.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user == User.guest
      redirect_to public_spots_path, alert: 'ゲストユーザーの編集はできません。'
    elsif @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to public_users_my_page_path
    else
      render :edit
    end
  end

  def withdraw
    if current_user.email == 'guest@example.com'
      redirect_to public_spots_path, alert: 'ゲストユーザーの退会はできません。'
    else
      @user = current_user
      @user.update(is_delete: true)
      reset_session
      redirect_to public_root_path
    end
  end

  def favorites
    favorites = Favorite.where(user_id: current_user.id).pluck(:spot_id)
    @favorite_spots = Spot.find(favorites)
  end

  private

  def user_params
     params.require(:user).permit(:nickname, :email)
  end
end
