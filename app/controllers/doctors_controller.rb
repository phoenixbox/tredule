class DoctorsController < ApplicationController
	def new
		@doctor = Doctor.new
	end
	def show
		@doctor = Doctor.find(params[:id])
	end
	def edit
		@doctor = Doctor.find(params[:id])
	end
	def create
		doctor = Doctor.create(params[:doctor])
		if doctor.save
			redirect_to doctor, notice: "Doctor account created successfully!"
		else
			render :new, notice: "Doctor account not created, please try again"
		end
	end
end