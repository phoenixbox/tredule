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

  def invitation(doctor, invite)
    @doctor = doctor
    @recipient_email = invite.recipient_email
    mail :to => invite.recipient_email, :subject => "Invitation to Tredule"
  end
end