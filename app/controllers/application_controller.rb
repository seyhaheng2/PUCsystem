class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  protect_from_forgery with: :exception
   before_filter :configure_permitted_parameters, if: :devise_controller?

     protected

       def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:username, :first_name, :last_name, :email, :password, :password_confirmation,:remember_me, roles: [])}
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :first_name, :last_name,:email, :password, :password_confirmation,:current_password, roles: [])}
        devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :first_name, :last_name ,:email, :password, :remember_me) }
      end
end
