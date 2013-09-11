class PatientsController < ApplicationController
	def new
		@patient = Patient.new
	end
	def create
		@patient = Patient.new(params[:patient])
		if @patient.save
			session[:user_email] = @patient.email
			redirect_to @patient, notice: "Patient account successfully created!"
		else
			render :new, flash: "Patient account not created"
		end
	end

	def show
		@patient = Patient.find(params[:id])
	end

	def edit
		@patient = Patient.find(params[:id])
	end

	def update
		@patient = Patient.find(params[:id])
		if @patient.update_attributes(params[:patient])
			redirect_to @patient
		else
			render :edit
		end
	end

	def destroy
		@patient = Patient.find(params[:id]).destroy
		logout_on_destroy
		redirect_to root_path, notice: "Patient account successfully deleted!"
	end
end