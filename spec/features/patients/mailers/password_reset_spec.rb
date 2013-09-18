require 'spec_helper'

feature "patient resets their password and relogs in" do
	let(:patient){FactoryGirl.create(:patient)}
	xit "successfullty resets password" do
		patient.send_password_reset
		visit edit_password_reset_path(patient.password_reset_token)
		save_and_open_page
		expect(page).to have_content("Reset Your Password")
	end
end