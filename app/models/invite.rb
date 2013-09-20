class Invite < ActiveRecord::Base
  attr_accessible :inviteable_id,
  								:inviteable_type,
  								:recipient_email,
  								:state,
                  :recipient_type,
  								:recipient_class

  belongs_to :inviteable, :polymorphic => true
  def send_invite
  	sender = self.inviteable_type.constantize.find(self.inviteable_id)
  	# TODO: change the invite state - test at the model layer
  	# TODO: switchboard Mailer based on what sender class is
  	DoctorMailer.invitation(sender, self).deliver
  end

  def find_sender
    self.inviteable_type.constantize.find(self.inviteable_id)
  end

  def create_recipient(params)
    recipient_class = self.recipient_type.capitalize.singularize.constantize
    recipient_class.create(params[self.recipient_type.singularize])
  end

  def find_recipient
    recipient_class = self.recipient_type.capitalize.singularize.constantize
    recipient_email = self.recipient_email
    recipient = recipient_class.find_by_email(recipient_email)
  end

  def associate(sender, recipient)
    sender.send(self.recipient_type) << recipient
  end

  def already_associated?(sender, recipient)
    sender.send(self.recipient_type).include?(recipient)
  end

  def instantiate_new_recipient
    self.recipient_type.capitalize.singularize.constantize.new
  end
end
