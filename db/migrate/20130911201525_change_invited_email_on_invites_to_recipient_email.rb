class ChangeInvitedEmailOnInvitesToRecipientEmail < ActiveRecord::Migration
	def change
		rename_column(:invites, :invited_email, :recipient_email)
	end
end
