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
		fill_in :email, :with => patient.email
		fill_in :password, :with => patient.password
		click_button "Log-In!"
		expect(page).to have_content(patient.first_name)
	end

	it "logs-out" do
		visit root_path
		fill_in :email, :with => patient.email
		fill_in :password, :with => patient.password
		click_button "Log-In!"
		expect(page).to have_link("Logout")
		save_and_open_page
		click_link("Logout")
		expect(page).to have_css('form.login-form')
	end
end