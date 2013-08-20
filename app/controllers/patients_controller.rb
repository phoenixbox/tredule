class PatientsController < ApplicationController
	def new
		@patient = Patient.new
	end

	def create
		@patient = Patient.new(params[:patient])
		if @patient.save
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
end