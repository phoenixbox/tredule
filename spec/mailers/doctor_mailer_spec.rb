require "spec_helper"

describe DoctorMailer do
  describe "password_reset" do
    let(:doctor) {FactoryGirl.create(:doctor, :password_reset_token => "qwerty")}
    let(:mail) { DoctorMailer.password_reset(doctor) }

    it "renders the headers and the reset link" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq(["doctor@example.com"])
      mail.from.should eq(["admin@tredule.com"])
      mail.body.encoded.should match(edit_password_reset_path(doctor.password_reset_token))
    end
  end
  describe 'signup confirmation' do
    let(:doctor) {FactoryGirl.create(:doctor, :password_reset_token => "qwerty")}
    let(:mail) { DoctorMailer.signup_confirmation(doctor) }

    it "renders the headers and the welcome message" do
      mail.subject.should eq("Signup Confirmation")
      mail.to.should eq(["doctor@example.com"])
      mail.from.should eq(["admin@tredule.com"])
      mail.body.encoded.should match("Welcome to Tredule")
    end
  end
  describe "invitation" do
    let(:doctor) {FactoryGirl.create(:doctor, :password_reset_token => "qwerty")}
    let(:invite){Invite.create(recipient_email:"patient@patient.com")}
    let(:mail) { DoctorMailer.invitation(doctor,invite) }

    it "renders the headers and the accept invitation link" do
      mail.subject.should eq("Invitation to Tredule!")
      mail.to.should eq(["patient@patient.com"])
      mail.from.should eq(["admin@tredule.com"])
      mail.body.encoded.should match("Invitation to Tredule!")
      mail.body.encoded.should match(invites_switch_path(doctor,invite))
    end
  end
end