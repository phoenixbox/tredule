require 'spec_helper'

feature "doctor emailed on" do
	let(:doctor){FactoryGirl.create(:doctor)}

	it "signup confirmation" do
	end

	it "password reset request" do
		visit root_path
		click_link "Forgot Password?"
		fill_in "Email", :with => doctor.email
		click_button "Send Reset Password Email"
		expect(page).to have_content("Email Sent!")
		expect(last_email.body).to have_content("Password Reset Request")
	end
end