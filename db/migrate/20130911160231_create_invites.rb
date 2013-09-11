class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :invited_email
      t.integer :inviteable_id
      t.string :inviteable_type
      t.string :state

      t.timestamps
    end
		add_index :invites, [:inviteable_id, :inviteable_type]
  end
end
