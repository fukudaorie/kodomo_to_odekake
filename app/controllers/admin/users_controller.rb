class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザーが削除されました。"
    redirect_to public_users_path
  end
end
