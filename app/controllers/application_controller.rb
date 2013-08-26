class ApplicationController < ActionController::Base
  protect_from_forgery

private

  helper_method :current_user, :logout_on_destroy

  def current_user
  	@current_user ||= find_user if session[:user_id]
  end

  def find_user
  	if Patient.exists?(session[:user_id])
  		Patient.find(session[:user_id])
  	else
  		Doctor.find(session[:user_id])
  	end
  end

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def authorize
    if !current_permission.allow?(params[:controller], params[:action])
      redirect_to root_path, alert: "You are not authorized to visit this page"
    end
  end

  def logout_on_destroy
  	session[:user_id] = nil
  end
end
