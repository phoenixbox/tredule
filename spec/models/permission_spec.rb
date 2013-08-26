require 'spec_helper'

RSpec::Matchers.define :authorize do |*args|
	match do |permission|
		expect(permission.allow?(*args)).to be_true
	end
end

describe Permission do
	describe "as a guest" do
		subject{ Permission.new(nil) }
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

	describe "as a patient" do
		patient = FactoryGirl.build(:patient)
		subject{ Permission.new(patient)}

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

	describe "as a doctor" do
		doctor = FactoryGirl.build(:doctor)
		subject{ Permission.new(doctor) }

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