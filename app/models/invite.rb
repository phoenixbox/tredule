class Invite < ActiveRecord::Base
  attr_accessible :inviteable_id, :inviteable_type, :recipient_email, :state
  belongs_to :inviteable, :polymorphic => true
  def send_invite
  	sender = self.inviteable_type.constantize.find(self.inviteable_id)
  	# TODO: change the invite state - test at the model layer
  	# TODO: switchboard Mailer based on what sender class is
  	DoctorMailer.invitation(sender, self).deliver
  end
end
