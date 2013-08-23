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
end