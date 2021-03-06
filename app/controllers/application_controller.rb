class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def is_admin?
    if !current_user.nil?
      current_user.is_admin?
    end
  end

  def is_member?
    if !current_user.nil?
      current_user.is_admin?
    end
  end


protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email,:password).merge!(:type => "Member", :is_active => true)}
    devise_parameter_sanitizer.for(:account_update) << [:name, :email, :mobile, :avatar]

  end
end
