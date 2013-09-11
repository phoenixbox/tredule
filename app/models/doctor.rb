class Doctor < ActiveRecord::Base

  has_many :doctors_patients
  has_many :patients, :through => :doctors_patients
  has_many :invites, :as => :inviteable

  attr_accessible :email,
  								:first_name,
  								:second_name,
  								:medical_school,
  								:mobile,
  								:password,
  								:password_confirmation,
  								:speciality,
  								:auth_token,
  								:password_reset_token,
  								:password_reset_at

	# Validations
	validates_presence_of :first_name, :second_name, :auth_token
	validates :email, presence: :true, uniqueness: :true,
	          format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ }

  has_secure_password

  before_validation :capitalize_name
  before_validation { generate_token(:auth_token) }


  def capitalize_name
		self.first_name.capitalize! && self.second_name.capitalize!
	end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_at = Time.zone.now
		save!
		DoctorMailer.password_reset(self).deliver
	end

	def generate_token(column)
		begin
		 self[column] = SecureRandom.urlsafe_base64
		end while Doctor.exists?(column => self[column])
	end
end
