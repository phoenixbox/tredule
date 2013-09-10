class DoctorMailer < ActionMailer::Base
  default from: "admin@tredule.com"

  def password_reset(doctor)
    @doctor = doctor
    mail :to => doctor.email, :subject => "Password Reset"
  end

  def signup_confirmation(doctor)
    @doctor = doctor
    mail :to => doctor.email, :subject => "Signup Confirmation"
  end
end