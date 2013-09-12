class InvitesController < ApplicationController
	def create
		# hit from the index of the subcontroller e.g. Doctors::Patients#index
		invited_type = request.env["HTTP_REFERER"].split('/').last
		allowed_types = ["doctors", "patients"]
		if allowed_types.include?(invited_type)
			invite = Invite.new(recipient_email: params[:email], invited_type: invited_type.singularize )
			current_user.invites << invite
			current_user.send_invite
			redirect_to :back, notice: "Invite Sent!"
		else
			redirect_to root_path, notice: "Invalid invite!"
		end
	end

	def switch
		binding.pry
		# TODO: switch is publically accessible but unless the invite's recipient_email exists for the doctor object then cant get to the signup page
		# TODO: unless the record exists they will go to the signup page
			# Do a record check based on email and invited_type
				# IF they exist then redirect to signin and make association there
				# ELSE redirect to create action

		# use the controller redirect!


		sender = params[:inviteable_type].constantize.find(params[:id])
		# render a view whose form will then hit the appropriate invited_type controller
		params[:invited_type].constantize.create(sender, params[:recipient_email])
		# We have the class passed back so we can find the inviter with the class and id
		# We have the new user email
	end
end
# States Options
# instantiated - new in the create block
# pending - sent via the mailer
# accepted - accepted via the link in the mailer and new record creation