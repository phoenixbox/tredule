require 'spec_helper'

feature "patient-doctor invitation" do
	describe "doctor does not exist" do
		let(:patient){FactoryGirl.create(:patient)}
		let(:invite){Invite.create(recipient_email:"doctor@doctor.com", recipient_type: "doctors")}
		it "can signup via a valid invite link" do
			patient.invites << invite
			visit invites_switch_path(invite)
			expect(page).to have_content("Accept Invitation")
			expect(page).to have_content("You have been invited to Tredule by #{patient.first_name} #{patient.second_name}")
			expect(page).to have_content("Accept Invitation")
			within(:css, "form#invite-signup"){
				fill_in :doctor_first_name, :with => "new"
				fill_in :doctor_second_name, :with => "doctor"
				fill_in :doctor_email, :with => invite.recipient_email
				fill_in :doctor_password, :with => "secret"
				fill_in :doctor_password_confirmation, :with => "secret"
				click_button "Sign-Up!"
			}
			expect(page).to have_content("New Account Successfully Created!")
		end
	end
	describe "doctor already exists" do
		let(:patient){FactoryGirl.create(:patient)}
		let(:doctor){FactoryGirl.create(:doctor)}
		let(:invite){Invite.create(recipient_email: doctor.email, recipient_type: "doctors")}

		it "can log-in and the association to the sender can be made" do
			patient.invites << invite
			visit invites_switch_path(invite)
			expect(page).to have_content("Log-In!")
			within(:css, "form.login-form"){
				fill_in :email, :with => doctor.email
				fill_in :password, :with => doctor.password
				click_button "Log-In!"
			}
			expect(page).to have_content("association to #{patient.first_name} #{patient.second_name} made!")
		end
		it "association already made then redirect to the new session path" do
			patient.invites << invite
			doctor.patients << patient
			visit invites_switch_path(invite)
			expect(page).to have_content("Invite already accepted, please Log-In!")
		end
	end
end