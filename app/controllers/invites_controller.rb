class InvitesController < ApplicationController
	def create
		# hit from the index of the subcontroller e.g. Doctors::Patients#index
		binding.pry
		invited_type = request.env["HTTP_REFERER"].split('/').last
		allowed_types = ["doctors", "patients"]
		if allowed_types.include?(invited_type)
			invite = Invite.new(recipient_email: params[:email], invited_type: invited_type.singularize )
			current_user.invites << invite
			current_user.send_invite
		end
		redirect_to :back, notice: "Invite Sent!"
	end

	def switch
		binding.pry
		# TODO: switch is publically accessible but unless the invite's recipient_email exists for the doctor object then cant get to the signup page
		# TODO: unless the record exists they will go to the signup page
		sender = params[:inviteable_type].constantize.find(params[:id])
		Patient.create(sender, params[:recipient_email])
		# We have the class passed back so we can find the inviter with the class and id
		# We have the new user email
	end
end
# States Options
# instantiated - new in the create block
# pending - sent via the mailer
# accepted - accepted via the link in the mailer and new record creation