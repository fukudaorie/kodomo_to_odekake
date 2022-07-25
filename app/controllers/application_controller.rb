class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :passward,children_attributes: [:id, :sex, :birth_date,:_destroy]])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :passward])

  end
end
