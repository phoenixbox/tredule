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
  	binding.pry
  	# TODO: accessible to guest so need some sort of secret question authentication etc. or is the auth token secure enough?
  end

private

  def find_user
  	begin
  		if patient ||= Patient.find_by_email(params[:email])
  			patient
  		else doctor ||= Doctor.find_by_email(params[:email])
  			doctor
  		end
  	rescue ActiveRecord::RecordNotFound
  		redirect_to root_path, notice: "No user with that email exists!"
  	end
  end
end
