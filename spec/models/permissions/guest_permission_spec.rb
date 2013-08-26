require 'spec_helper'

describe Permissions::GuestPermission do
	describe "as a guest" do
		subject{ Permissions.permission_for(nil) }

		it "authorize home [index]" do
			should authorize("home","index")
		end

		it "authorize patients[new create]" do
			should authorize('patients', 'new')
			should authorize('patients', 'create')
		end

		it "not authorize patients [index show edit update destroy]" do
			should_not authorize("patients", "index")
			should_not authorize("patients", "show")
			should_not authorize("patients", "edit")
			should_not authorize("patients", "update")
			should_not authorize("patients", "destroy")
		end

		it "authorize sessions [create destroy]" do
		 	should authorize('sessions','create')
		 	should authorize('sessions','destroy')
		end

		it "authorize doctors [new create]" do
			should authorize('doctors','new')
			should authorize('doctors','create')
		end

		it "not authorize doctors [show edit update destroy]" do
			should_not authorize('doctors','show')
			should_not authorize('doctors','edit')
			should_not authorize('doctors','update')
			should_not authorize('doctors','destroy')
		end
	end
end