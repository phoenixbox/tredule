class Patient < ActiveRecord::Migration
  def change
  	create_table :patients do |t|
  		t.string :first_name
  		t.string :second_name
  		t.string :email
  		t.string :mobile
  		t.string :dob
  		t.string :insurance_provider
  		t.string :policy_number
  		t.string :medical_card_number
  		t.string :password_digest
  	end
  end
end