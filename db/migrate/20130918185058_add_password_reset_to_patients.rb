class AddPasswordResetToPatients < ActiveRecord::Migration
  def change
  	add_column :patients, :password_reset_token, :string
  	add_column :patients, :password_reset_at, :datetime
  end
end