class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update

      @user = User.find(params[:id])
      @user.update(user_params)
      redirect_to public_users_my_page_path
  end

  def unsubscribe
  end

  def withdraw
    if current_user.email == 'guest@example.com'
      redirect_to public_spots_path, alert: 'ゲストユーザーの編集・削除できません。'
    else
      @user = current_user
      @user.update(is_delete: true)
      reset_session
      redirect_to public_root_path
    end
  end

  private

  def user_params
     params.require(:user).permit(:nickname, :email)
  end
end
