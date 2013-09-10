require 'spec_helper'

feature 'Guest signs up' do
	it 'to become a PATIENT with valid attributes' do
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

	it 'to become a DOCTOR with valid attributes' do
		visit new_doctor_path
		within(:css, "form#new-doctor-form") {
			fill_in 'doctor_first_name', :with => 'rapahel'
			fill_in 'doctor_second_name', :with => 'weiner'
			fill_in 'doctor_email', :with => 'raphael@doctor.com'
			fill_in 'doctor_password', :with => 'secret'
			fill_in 'doctor_password_confirmation', :with => 'secret'
			click_button 'Sign-Up!'
		}
		expect(page).to have_content('Rapahel')
	end

	it 'to become a patient with invalid attributes' do
		visit new_patient_path
		within(:css, "form#new-patient-form") {
			fill_in 'patient_first_name', :with => 'shane'
			fill_in 'patient_second_name', :with => ''
			fill_in 'patient_email', :with => '!#$@.com'
			fill_in 'patient_password', :with => 'secret'
			fill_in 'patient_password_confirmation', :with => 'secret'
			click_button 'Sign-Up!'
		}
		expect(page).to have_content('Sorry, you entered incorrect details:')
	end
end