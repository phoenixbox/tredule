require 'spec_helper'

describe Doctor do
	subject do
		FactoryGirl.create(:doctor)
	end
  it "delivers password reset email to doctor" do
    subject.send_password_reset
    expect(last_email.body.encoded).to include("Password Reset Request")
  end
  it "generates a unique password reset token every time" do
  	subject.send_password_reset
  	last_token = subject.password_reset_token
  	subject.send_password_reset
  	expect(subject.password_reset_token).to_not eq last_token
  end
  it "saves the time the password was sent" do
  	subject.send_password_reset
  	expect(subject.reload.password_reset_at).to be_present
  end
end