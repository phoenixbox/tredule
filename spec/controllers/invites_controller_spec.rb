require 'spec_helper'

describe InvitesController do
	describe "GET#switch" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			@doctor.invites.create(
															recipient_email:"invited_patient@patient.com",
															recipient_type:"patient"
														)
			@invite = @doctor.invites.last
		end
		# TODO: Works a part from the redirect
		xit "hits the switch action and redirects to the doctors::patient#create when the patient does not exist" do
			get :switch, :id => @invite

			# redirect_to doctors_new_patient_path(@doctor, @invite.recipient_email)
		end
	end
end
# set intended recipient type?