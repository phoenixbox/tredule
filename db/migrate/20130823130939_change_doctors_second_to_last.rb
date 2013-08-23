class ChangeDoctorsSecondToLast < ActiveRecord::Migration
  def change
  	change_table :doctors do |t|
  		t.rename :last_name, :second_name
  	end
  end
end
