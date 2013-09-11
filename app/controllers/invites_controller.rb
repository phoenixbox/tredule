class InvitesController < ApplicationController
	def create
		# binding.pry
		# create an invite with the recipient email
		invite = Invite.new(recipient_email: params[:email])
		# associate it with the current_user
		current_user.invites << invite
		# send the email
		current_user.send_invite
		redirect_to :back, notice: "Invite Sent!"
	end

	def switch
		# TODO: switch is publically accessible but unless the invite's recipient_email exists for the doctor object then cant get to the signup page
		# TODO: unless the record exists they will go to the signup page
	end
end
# instantiated - new in the create block
# pending - sent via the mailer
# accepted - accepted via the link in the mailer and new record creation