require 'spec_helper'

feature 'Patient visits the hompage' do
	let(:patient){FactoryGirl.create(:patient)}
	it 'sees the login form' do
		visit root_path
		within(:css, 'form.login-form'){
			expect(page).to have_field('email')
			expect(page).to have_field('password')
		}
	end

	it "logs-in through form" do
		visit root_path
		log_in(patient)
		expect(page).to have_content(patient.first_name)
	end

	it "logged in user redirect to patient show when try to visit index" do
		visit root_path
		log_in(patient)
		visit root_path
		expect(page).to have_content(patient.first_name)
	end

	it "logs-out" do
		visit root_path
		log_in(patient)
		expect(page).to have_link("Logout")
		click_link("Logout")
		expect(page).to have_css('form.login-form')
	end

	it 'unauthenticated cant see the logout link' do
		visit patient_path(patient)
		expect(page).to_not have_content(patient.first_name)
	end
end