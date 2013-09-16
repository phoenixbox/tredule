require 'spec_helper'

feature "doctor-patient invitation" do
	describe "patient does not exist" do
		let(:doctor){FactoryGirl.create(:doctor)}
    let(:invite){Invite.create(recipient_email:"patient@patient.com", recipient_type: "patients")}

		it "can sign up via invite link" do
			doctor.invites<<invite
			visit invites_switch_path(invite)
			expect(page).to have_content("Accept Invitation")
			# within(:css, "form#invite-signup"){
			# 	fill_in :first_name, :with => "new"
			# 	fill_in :second_name, :with => "patient"
			# 	fill_in :email, :with => invite.recipient_email
			# 	fill_in :password, :with => "secret"
			# 	fill_in :password_confirmation, :with => "secret"
			# 	click_button "Sign-up!"
			# }
			# expect(page).to have_content("Account Successfully Created!")
		end
	end
	describe "patient already exists" do
		it "can sign-in and the association can to the inviter can made" do
		end
	end
end