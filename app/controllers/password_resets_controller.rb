class PasswordResetsController < ApplicationController
	# Guest functionality so no access to the current_user
  def new
  end
	# TODO: Make dynamic across all user types
  def create
  	doctor = Doctor.where(email: params[:email]).first
 		doctor.send_password_reset
  	redirect_to root_path, notice: "Email Sent!"
  end
end
