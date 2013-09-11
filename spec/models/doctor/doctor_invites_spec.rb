require 'spec_helper'

describe Doctor do
	let(:invite){Invite.create(recipient_email:"pateient@patient.com")}
	subject do
		FactoryGirl.create(:doctor)
	end

	it "delivers the invite email to the patient" do
		subject.invites << invite
		subject.invites.last.send_invite
		expect(last_email.body.encoded).to include("Invitation to Tredule!")
	end
end