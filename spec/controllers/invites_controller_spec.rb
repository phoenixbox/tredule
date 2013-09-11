require 'spec_helper'

describe InvitesController do
	describe "GET#switchboard" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			@doctor.invites.create(recipient_email:"example@example.com")
			@invite = @doctor.invites.last
		end
		# TODO: Works a part from the redirect
		xit "hits the switch action" do
			get :switch, :id => @doctor.id, :email => @invite.recipient_email
			expect(response).to redirect_to invites_switch_path(@doctor, @invite.recipient_email)
		end
	end
end