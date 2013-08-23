class Patient < ActiveRecord::Base

	has_many :doctors_patients
	has_many :doctors, :through => :doctors_patients

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

	validates_presence_of :first_name, :second_name
	validates :email, presence: :true, uniqueness: :true,
	          format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }

	has_secure_password

	before_validation :capitalize_name

	def capitalize_name
		self.first_name.capitalize! && self.second_name.capitalize!
	end
end