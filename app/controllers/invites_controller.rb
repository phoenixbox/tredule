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
		begin
			invite = Invite.find(params[:id])
			if invite.find_recipient.nil?
				redirect_to invite_create_and_associate_path(invite)
			else recipient = invite.find_recipient
				sender = invite.find_sender
				if invite.already_associated?(sender, recipient)
					redirect_to root_path, notice: "Invite already accepted, please Log-In!"
				else
					redirect_to invites_new_session_path(invite)
				end
			end
		rescue ActiveRecord::RecordNotFound
			redirect_to root_path, notice: "Invalid Invite!"
		end
	end

	def create_and_associate
		invite = Invite.find(params[:id])
		@sender = invite.find_sender
		@new_user = invite.instantiate_new_recipient
	end

	def signup
		invite = Invite.find(params[:id])
		recipient = invite.create_recipient(params)
		if recipient.save
			sender = invite.find_sender
			invite.associate(sender, recipient)
			session[:user_email] = recipient.email
			redirect_to recipient, notice: "New Account Successfully Created!"
		else
			render :create_and_associate, notice: "Error with account creation, please check your submitted details!"
		end
	end

	def new_session
		invite = Invite.find(params[:id])
		recipient = invite.find_recipient
		sender = invite.find_sender
		if invite.already_associated?(sender, recipient)
			redirect_to root_path, notice: "Invite already accepted, please Log-In!"
		end
	end

	def login_and_associate
		invite = Invite.find(params[:id])
		recipient = invite.find_recipient
		if recipient && recipient.authenticate(params[:password])
			sender = invite.find_sender
			invite.associate(sender, recipient)
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