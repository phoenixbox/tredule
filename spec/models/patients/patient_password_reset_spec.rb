require 'spec_helper'

describe Patient do
	subject do
		FactoryGirl.create(:patient)
	end

	it "sends the password reset email" do
		subject.send_password_reset
		expect(last_email.body.encoded).to include "Password Reset Request"
	end

	it "sets the password reset token" do
		subject.send_password_reset
		expect(subject.password_reset_token).to be_present
		old_token = subject.password_reset_token
		subject.send_password_reset
		expect(subject.password_reset_token).to_not eq(old_token)
	end

	it "sets the password reset at" do
		subject.send_password_reset
		expect(subject.password_reset_at).to be_present
		old_token = subject.password_reset_at
		subject.send_password_reset
		expect(subject.password_reset_at).to_not eq(old_token)
	end
end