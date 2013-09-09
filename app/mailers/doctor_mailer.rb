class DoctorMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(doctor)
    @doctor = doctor
    mail :to => doctor.email, :subject => "Password Reset"
  end
end