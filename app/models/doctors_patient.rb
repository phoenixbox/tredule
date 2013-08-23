class DoctorsPatient < ActiveRecord::Base
	attr_accessible :doctor, :patient

	belongs_to :doctor
	belongs_to :patient
end