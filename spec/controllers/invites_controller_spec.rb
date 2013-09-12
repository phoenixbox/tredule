require 'spec_helper'

describe InvitesController do
	describe "GET#switchboard" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			@doctor.invites.create(recipient_email:"example@example.com")
			@invite = @doctor.invites.last
		end
		# TODO: Works a part from the redirect
		it "hits the switch action and redirects to the patient create when the patient does not exist" do
			get :switch, :id => @doctor, :email => @invite.recipient_email, :inviteable_type => @invite.inviteable_type
			expect(response).to redirect_to new_patient_path(@doctor, @invite.recipient_email)
		end
	end
end
# set intended recipient type?