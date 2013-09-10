class SessionsController < ApplicationController
	def create
		user = find_patient(params) || find_doctor(params)
		if user && user.authenticate(params[:password])
			session[:user_email] = user.email
			redirect_to user, notice: "Logged in successfully!"
		else
		redirect_to root_path, error: "Incorrect Information"
		end
	end

	def destroy
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