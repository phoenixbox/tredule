class HomeController < ApplicationController
	def index
		if current_user
			redirect_to patient_path(current_user)
		else
			@patient = Patient.new
		end
	end
end