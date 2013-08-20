require 'spec_helper'

feature 'guest signs up' do
	it 'to become a patient' do
		visit new_patient_path
		within(:css, "form#new-patient-form") {
			fill_in 'patient_first_name', :with => 'shane'
			fill_in 'patient_second_name', :with => 'rogers'
			fill_in 'patient_email', :with => 'shane@example.com'
			fill_in 'patient_password', :with => 'secret'
			fill_in 'patient_password_confirmation', :with => 'secret'
			click_button 'Sign-Up!'
		}
		expect(page).to have_content('Shane')
	end
end