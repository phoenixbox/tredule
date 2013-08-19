class HomeController < ApplicationController
	def index
		@patient = Patient.new
	end
end