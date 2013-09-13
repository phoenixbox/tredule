require 'spec_helper'

feature "doctor-patient invitation" do
	describe "patient does not exist" do
		let(:doctor){FactoryGirl.create(:doctor)}
    let(:invite){Invite.create(recipient_email:"patient@patient.com", recipient_type: "patients")}

		it "can sign up via invite link" do
			doctor.invites<<invite
			visit invites_switch_path(invite)
			save_and_open_page
			expect(page).to have_content("Accept Invitation")
		end
	end
	describe "patient already exists" do
		it "can sign-in and the association can to the inviter can made" do
		end
	end
end