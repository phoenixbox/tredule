class ChangeDoctorsPatientsPatientsId < ActiveRecord::Migration
  def change
  	change_table :doctors_patients do |t|
  		t.rename :patients_id, :patient_id
  	end
  end
end