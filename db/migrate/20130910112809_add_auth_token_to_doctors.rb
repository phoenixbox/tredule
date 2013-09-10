class AddAuthTokenToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :auth_token, :string
  end
end
