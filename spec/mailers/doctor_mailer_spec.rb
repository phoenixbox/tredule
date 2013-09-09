require "spec_helper"

describe DoctorMailer do
  describe "password_reset" do
    let(:doctor) {FactoryGirl.create(:doctor, :password_reset_token => "qwerty")}
    let(:mail) { DoctorMailer.password_reset(doctor) }

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq(["doctor@example.com"])
      mail.from.should eq(["from@example.com"])
      mail.body.encoded.should match(edit_password_reset_path(doctor.password_reset_token))
    end
  end
end