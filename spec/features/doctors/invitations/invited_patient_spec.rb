require 'spec_helper'

feature "doctor-patient invitation" do
	describe "patient does not exist" do
		let(:doctor){FactoryGirl.create(:doctor)}
    let(:invite){Invite.create(recipient_email:"patient@patient.com", recipient_type: "patients")}

		it "can sign up via invite link" do
			doctor.invites<<invite
			visit invites_switch_path(invite)
			expect(page).to have_content("Accept Invitation")
			expect(page).to have_content("You have been invited to Tredule by #{doctor.first_name} #{doctor.second_name}")
			expect(page).to have_content("Accept Invitation")
			within(:css, "form#invite-signup"){
				fill_in :patient_first_name, :with => "new"
				fill_in :patient_second_name, :with => "patient"
				fill_in :patient_email, :with => invite.recipient_email
				fill_in :patient_password, :with => "secret"
				fill_in :patient_password_confirmation, :with => "secret"
				click_button "Sign-Up!"
			}
			expect(page).to have_content("Account Successfully Created!")
		end
	end
	describe "patient already exists" do
		let(:doctor){FactoryGirl.create(:doctor)}
		let(:patient){FactoryGirl.create(:patient)}
		let(:invite){Invite.create(recipient_email: patient.email, recipient_type: "patients")}

		it "can sign-in and the association can to the inviter can made" do
			doctor.invites<<invite
			visit invites_switch_path(invite)
			expect(page).to have_content("Log-In!")
			within(:css, "form.login-form"){
				fill_in :email, :with => patient.email
				fill_in :password, :with => patient.password
				click_button "Log-In!"
			}
			expect(page).to have_content("association to #{doctor.first_name} #{doctor.second_name} made!")
		end
	end
end