class Doctor < ActiveRecord::Base

  has_many :doctors_patients
  has_many :patients, :through => :doctors_patients

  attr_accessible :email, :first_name, :second_name, :medical_school, :mobile, :password, :speciality

	# Validations
	validates_presence_of :first_name, :second_name
	validates :email, presence: :true, uniqueness: :true,
	          format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }

  has_secure_password

  before_validation :capitalize_name

  def capitalize_name
		self.first_name.capitalize! && self.second_name.capitalize!
	end
end
