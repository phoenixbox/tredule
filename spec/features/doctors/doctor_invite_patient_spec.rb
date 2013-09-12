require 'spec_helper'

feature "doctor invites a patient by email:" do
	let(:doctor){FactoryGirl.create(:doctor)}
	let(:patient){FactoryGirl.create(:patient)}

	it "whom is already a Tredule member, to be the doctor's patient" do
		log_in(doctor)
		visit doctor_path(doctor)
		expect(page).to have_content("Logged in as:")
		click_link "Patient List"
		expect(page).to have_content("#{doctor.first_name}'s Patients")
		within(:css, "div#invite-patient-form"){
			fill_in :email, :with => patient.email
			click_button "Invite Patient"
		}
		expect(page).to have_content("Invite Sent!")
	end
end