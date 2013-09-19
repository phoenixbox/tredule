class PasswordResetsController < ApplicationController
	# Guest functionality so no access to the current_user
	before_filter :find_user, only: :create

  def new
  end

  def create
 		find_user.send_password_reset
  	redirect_to root_path, notice: "Email Sent!"
  end

  def edit
  	@user = find_by_user_token(params)
  end

  def update
  	@user = find_by_user_token(params)
  	binding.pry
  	if @user.password_reset_at < 2.hours.ago
  		redirect to new_password_reset_path, notice: "Password Reset Expired!"
  	elsif @user.update_attributes(params[@user.class.name.downcase])
  		session[:user_email] = @user.email
  		redirect_to @user, notice: "Password Reset!"
  	else
  		render :edit
  	end
  end

private

  def find_user
  	begin
  		if patient = Patient.find_by_email(params[:email])
  			patient
  		else doctor = Doctor.find_by_email(params[:email])
  			doctor
  		end
  	rescue ActiveRecord::RecordNotFound
  		redirect_to root_path, notice: "No user with that email exists!"
  	end
  end

  def find_by_user_token(params)
		if Patient.find_by_password_reset_token(params[:id]) != nil
			patient = Patient.find_by_password_reset_token(params[:id])
		elsif Doctor.find_by_password_reset_token(params[:id]) != nil
			doctor = Doctor.find_by_password_reset_token(params[:id])
		else
			redirect_to root_path, notice: "Invalid Reset Token!"
  	end
  end
end
