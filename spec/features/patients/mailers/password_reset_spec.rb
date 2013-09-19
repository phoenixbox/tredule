require 'spec_helper'

feature "patient resets their password and relogs in" do
	let(:patient){FactoryGirl.create(:patient)}
	it "successfullty resets password" do
		patient.send_password_reset
		visit edit_password_reset_path(patient.password_reset_token)
		expect(page).to have_content("Reset Your Password")
		within(:css, "form#password-reset"){
			fill_in :patient_password, :with => patient.password
			fill_in :patient_password_confirmation, :with => patient.password
			click_button "Update Password"
		}
		expect(page).to have_content("Password Reset!")
	end

	it "rejects because of a bad token" do
		visit edit_password_reset_path("xxxxxxxxxxxxx")
		expect(page).to have_content("Invalid Reset Token")
	end


	xit "redirects becasue the token is old" do
		patient.send_password_reset
		visit edit_password_reset_path(patient.password_reset_token)
		expect(page).to have_content("Reset Your Password")
		within(:css, "form#password-reset"){
			fill_in :patient_password, :with => patient.password
			fill_in :patient_password_confirmation, :with => patient.password
			click_button "Update Password"
		}
		expect(page).to have_content("Password Reset Expired!")
	end
end