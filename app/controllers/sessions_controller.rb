class SessionsController < ApplicationController
	def create
		user = find_patient(params) || find_doctor(params)
		if user && user.authenticate(params[:password])
			if params[:remember_me]
				cookies.permanent[:auth_token] = user.auth_token
			else
				cookies[:auth_token] = user.auth_token
			end
			session[:user_email] = user.email
			redirect_to user, notice: "Logged in successfully!"
		else
		redirect_to root_path, error: "Incorrect Information"
		end
	end

	def destroy
		cookies.delete(:auth_token)
		session[:user_email] = nil
		redirect_to root_path
	end

private

	def find_patient(params)
		Patient.find_by_email(params[:email])
	end

	def find_doctor(params)
		Doctor.find_by_email(params[:email])
	end
end