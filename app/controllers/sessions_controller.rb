class SessionsController < ApplicationController
	def create
		patient = Patient.find_by_email(params[:email])
		if patient && patient.authenticate(params[:password])
			session[:user_id] = patient.id
			redirect_to patient_path(patient), notice: "Logged in successfully!"
		else
			redirect_to root_path, error: "Incorrect Information"
		end
	end
end