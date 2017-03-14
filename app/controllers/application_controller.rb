class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :user_signed_in?
  helper_method :current_user_name
  helper_method :current_user_id
  helper_method :current_user
  def user_signed_in?
      session[:user_id] ? true : false
  end
  def current_user_name
      session[:user_name]
  end
  def current_user_id
      session[:user_id]
  end
  def current_user
      User.find(session[:user_id]) if session[:user_id]
  end
  def salt_n_hash s
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(s, password_salt)
    password_hash
  end
  
  
  #before_action :configure_permitted_parameters, if: :devise_controller?
  
  #protected 
  #def configure_permitted_parameters
  #  devise_parameter_sanitizer.permit(:sign_up) {|u| u.permit(:username, :email, :password, :password_confirmation, :rememeber_me)     }
  #  devise_parameter_sanitizer.permit(:sign_in){|u| u.permit(:username, :email, :password, :password_confirmation, :rememeber_me)    }
  #  devise_parameter_sanitizer.permit(:account_update){|u| u.permit(:email, :password, :password_confirmation, :rememeber_me)     }
  #end
  
end
