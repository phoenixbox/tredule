require 'spec_helper'

feature "doctor resets their password and logsin" do
	let(:doctor){FactoryGirl.create(:doctor)}
	it "sucessfully resets the password" do
		doctor.send_password_reset
		visit edit_password_reset_path(doctor.password_reset_token)
		expect(page).to have_content("Reset Your Password")
		within(:css, "form#password-reset"){
			fill_in :doctor_password, :with => "newPassword"
			fill_in :doctor_password_confirmation, :with => "newPassword"
			click_button "Update Password"
		}
		expect(page).to have_content("Password Reset!")
	end

	xit "redirects becasue the token is old" do
		doctor.send_password_reset
		visit edit_password_reset_path(doctor.password_reset_token)
		expect(page).to have_content("Reset Your Password")
		within(:css, "form#password-reset"){
			fill_in :doctor_password, :with => "newPassword"
			fill_in :doctor_password_confirmation, :with => "newPassword"
			click_button "Update Password"
		}
		expect(page).to have_content("Password Reset Expired!")
	end
end