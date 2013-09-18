class PatientMailer < ActionMailer::Base
  default from: "admin@tredule.com"

  def password_reset(patient)
    @patient = patient
    mail :to => patient.email, :subject => "Password Reset"
  end
end