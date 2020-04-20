class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
  
  helper_method :current_user, :logged_in?, :login_check
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  # def login_check
  #   if current_user.nil?
  #     redirect_to root_url, danger: "ログインしてください"
  #   end
  # end
end
