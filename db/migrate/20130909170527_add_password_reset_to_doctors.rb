class AddPasswordResetToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :password_reset_token, :string
    add_column :doctors, :password_reset_at, :datetime
  end
end
