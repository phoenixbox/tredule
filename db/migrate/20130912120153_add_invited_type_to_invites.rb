class AddInvitedTypeToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :invited_type, :string
  end
end
