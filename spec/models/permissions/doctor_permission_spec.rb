require 'spec_helper'

describe Permissions::DoctorPermission do
	describe "as a doctor" do
		doctor = FactoryGirl.build(:doctor)
		subject{ Permissions.permission_for(doctor) }

		it "authorize home [index]" do
			should authorize("home","index")
		end

		it "authorize doctors [show edit update destroy]" do
			should authorize("doctors", "show")
			should authorize("doctors", "edit")
			should authorize("doctors", "update")
			should authorize("doctors", "destroy")
		end
		it "not authorize doctors [index new create]" do
			should_not authorize("doctors", "index")
			should_not authorize("doctors", "new")
			should_not authorize("doctors", "create")
		end
		it "not authorize patients [index show new create edit update destroy]" do
			should_not authorize("patients","index")
			should_not authorize("patients","show")
			should_not authorize("patients","new")
			should_not authorize("patients","create")
			should_not authorize("patients","edit")
			should_not authorize("patients","update")
			should_not authorize("patients","destroy")
		end
	end
end