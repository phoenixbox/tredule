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
									:auth_token,
									:password,
									:password_confirmation

	validates_presence_of :first_name, :second_name, :auth_token
	validates :email, presence: :true, uniqueness: :true,
	          format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }

	has_secure_password

	before_validation :capitalize_name
	before_validation { generate_token(:auth_token) }


	def capitalize_name
		self.first_name.capitalize! && self.second_name.capitalize!
	end

	def generate_token(column)
		begin
		 self[column] = SecureRandom.urlsafe_base64
		end while Patient.exists?(column => self[column])
	end
end