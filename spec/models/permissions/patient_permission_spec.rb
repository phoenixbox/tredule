require 'spec_helper'

describe Permissions::PatientPermission do
	describe "as a patient" do
		patient = FactoryGirl.build(:patient)
		subject{ Permissions.permission_for(patient)}

		it 'authorize home [index]' do
			should authorize("home","index")
		end

		it 'authorize patients [show edit update destroy]' do
			should authorize("patients","show")
			should authorize("patients","edit")
			should authorize("patients","update")
			should authorize("patients","destroy")
		end

		it "not authorize patients [index new create]" do
			should_not authorize("patients","create")
			should_not authorize("patients","new")
			should_not authorize("patients", "index")
		end

		it "authorize sessions [create destroy]" do
			should authorize("sessions", "create")
			should authorize("sessions", "destroy")
		end

		it "not authorize doctors [index show new create update destroy]" do
			should_not authorize("doctors", "index")
			should_not authorize("doctors", "show")
			should_not authorize("doctors", "new")
			should_not authorize("doctors", "create")
			should_not authorize("doctors", "update")
			should_not authorize("doctors", "destroy")
		end
	end
end