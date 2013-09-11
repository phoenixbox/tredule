class Invite < ActiveRecord::Base
  attr_accessible :inviteable_id, :inviteable_type, :invited_email, :state
  belongs_to :inviteable, :polymorphic => true
end
