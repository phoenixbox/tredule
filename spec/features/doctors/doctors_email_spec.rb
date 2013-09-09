require 'spec_helper'

feature "doctor emails on" do
	let(:doctor){FactoryGirl.create(:doctor)}

	it "signup confirmation" do
	end

	it "password reset request" do
		visit root_path
		click_link "Forgot Password?"
		fill_in "Email", :with => doctor.email
		click_button "Send Reset Password Email"
	end
end