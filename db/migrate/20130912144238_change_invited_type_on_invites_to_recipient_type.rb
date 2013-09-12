class ChangeInvitedTypeOnInvitesToRecipientType < ActiveRecord::Migration
	def change
		rename_column(:invites, :invited_type, :recipient_type)
	end
end
