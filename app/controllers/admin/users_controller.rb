class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.order('id DESC').page(params[:page]).per(10)
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_delete: true)
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to admin_users_path
  end
end
