class SessionsController < ApplicationController
	def create
		user = find_patient(params) || find_doctor(params)
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect_to user, notice: "Logged in successfully!"
		else
		redirect_to root_path, error: "Incorrect Information"
		end
	end

	def find_patient(params)
		Patient.find_by_email(params[:email])
	end

	def find_doctor(params)
		Doctor.find_by_email(params[:email])
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end