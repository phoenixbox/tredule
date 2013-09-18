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
		# TODO check invite validity
		recipient_class = invite.recipient_type.capitalize.singularize.constantize
		recipient_email = invite.recipient_email
		if recipient_class.find_by_email(recipient_email).nil?
			# doesnt exist - then create
			redirect_to invite_create_and_associate_path(invite)
		elsif recipient_class.find_by_email(recipient_email)
			# does exist - signin
			redirect_to invites_new_session_path(invite)
		else
			# catch all redirect to home - need to combine to invite validity check - remove me
			redirect_to root_path, notice: "Not authorized!"
		end
	end

	def create_and_associate
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
			render :create_and_associate, notice: "Error with account creation, please check your submitted details!"
		end
	end

	def new_session
		# TODO RESTART!! : how did pass the id in the last path?
		# want to use this form to new_session and then make the association :)
	end

	def login_and_associate
		invite = Invite.find(params[:id])
		recipient_class = invite.recipient_type.capitalize.singularize.constantize
		recipient_email = invite.recipient_email
		recipient = recipient_class.find_by_email(recipient_email)
		if recipient && recipient.authenticate(params[:password])
			sender = invite.inviteable_type.constantize.find(invite.inviteable_id)
			sender.send(invite.recipient_type) << recipient
			session[:user_email] = recipient.email
			redirect_to recipient, notice: "Logged in successfully!, association to #{sender.first_name} #{sender.second_name} made!"
		else
			redirect_to :back, error: "Incorrect Information"
		end
	end
end
# States Options
# instantiated - new in the create block
# pending - sent via the mailer
# accepted - accepted via the link in the mailer and new record creation