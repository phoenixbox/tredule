class DoctorsController < ApplicationController
	before_filter :authorize, except: [:new, :create]

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
	def update
		doctor = Doctor.find(params[:id])
		if doctor.update_attributes(params[:doctor])
			redirect_to doctor, notice: "Account updated!"
		else
			render :edit, notice: "Update failed"
		end
	end
	def destroy
		doctor = Doctor.find(params[:id]).destroy
		logout_on_destroy
		redirect_to root_path, notice: "Doctor account successfully deleted!"
	end
end