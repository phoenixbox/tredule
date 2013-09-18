require 'spec_helper'

feature "patient emailed on" do
	let(:patient){FactoryGirl.create(:patient)}

	it "signup confirmation" do

	end

	it "password reset request" do
		visit root_path
		click_link "Forgot Password?"
		fill_in "Email", :with => patient.email
		click_button "Send Reset Password Email"
		expect(page).to have_content("Email Sent!")
		expect(last_email.body).to have_content("Password Reset Request")
	end
end