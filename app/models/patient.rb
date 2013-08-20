class Patient < ActiveRecord::Base

	attr_accessible :first_name,
									:second_name,
									:email,
									:mobile,
									:dob,
									:insurance_provider,
									:policy_number,
									:medical_card_number,
									:password,
									:password_confirmation

	has_secure_password

	before_validation :capitalize_name

	def capitalize_name
		self.first_name.capitalize! && self.second_name.capitalize!
	end
end