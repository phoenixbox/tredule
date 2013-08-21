class ApplicationController < ActionController::Base
  protect_from_forgery

private

  helper_method :current_user

  def current_user
  	@current_user ||= Patient.find(session[:user_id]) if session[:user_id]
  end

  def authorize
  	redirect_to root_path, alert: "You are not authorized to visit this page" if current_user.nil?
  end
end
