class InvitesController < ApplicationController
	def create
		# hit from the index of the subcontroller e.g. Doctors::Patients#index
		recipient_type = request.env["HTTP_REFERER"].split('/').last
		allowed_types = ["doctors", "patients"]
		if allowed_types.include?(recipient_type)
			invite = Invite.new(recipient_email: params[:email], recipient_type: recipient_type.singularize )
			current_user.invites << invite
			current_user.send_invite
			redirect_to :back, notice: "Invite Sent!"
		else
			redirect_to root_path, notice: "Invalid invite!"
		end
	end

	def switch
		invite = Invite.find(params[:id])
		# TODO: Make sure invitation has a recipient type so cant just enter in an id - if recipient type is not ok then redirect_to root_url - duplication with create method so extract to its own method - use on all actions?
		recipient_class = invite.recipient_type.capitalize.singularize.constantize
		recipient_email = invite.recipient_email
		if recipient_class.find_by_email(recipient_email).nil?
			redirect_to invite_accept_and_register_path(invite)
		elsif
			redirect_to new_session_path(params)
		else
			redirect_to root_path, notice: "Not authorized!"
		end
	end

	def accept_and_register
		invite = Invite.find(params[:id])
		@sender = invite.inviteable_type.constantize.find(invite.inviteable_id)

		# invitation is a readonly value, make sure invite is valid
		recipient_class = invite.recipient_type.capitalize.singularize.constantize
		@new_user = recipient_class.new
	end

	def signup
		invite = Invite.find(params[:id])
		recipient_class = invite.recipient_type.capitalize.singularize.constantize
		sender = invite.inviteable_type.constantize.find(invite.inviteable_id)
		new_user = recipient_class.create(params[invite.recipient_type.singularize])
		if new_user.save
			sender.send(invite.recipient_type) << new_user
			session[:user_email] = new_user.email
			redirect_to new_user, notice: "New Account Successfully Created!"
		else
			render :accept_and_register, notice: "Error with account creation, please check your submitted details!"
		end
	end
end
# States Options
# instantiated - new in the create block
# pending - sent via the mailer
# accepted - accepted via the link in the mailer and new record creation