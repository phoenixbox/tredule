require 'spec_helper'

feature "patient can edit their profile" do
	let(:patient){FactoryGirl.create(:patient)}

	it "can see the edit form" do
		log_in(patient)
		visit patient_path(patient)
		expect(page).to have_link("Edit Profile")
		click_link "Edit Profile"
		expect(page).to have_css('form#edit-patient-form')
		expect(page).to have_field('Insurance provider')
	end

	it "can change its details with valid attributes" do
		edit_patient(patient)
		patient.reload
		expect(page).to have_content(patient.first_name)
	end

	it "cant change its details with invalid attributes" do
		edit_patient(patient, {email: '!#$%@!!.com'})
	end

	it "can destroy their account" do
		log_in(patient)
		visit edit_patient_path(patient)
		expect(page).to have_button("Delete Account")
		click_button("Delete Account")
		expect(current_path).to eq(root_path)
	end
end