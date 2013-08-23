class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile
      t.string :email
      t.string :password_digest
      t.string :speciality
      t.string :medical_school

      t.timestamps
    end
  end
end
