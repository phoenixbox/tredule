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
			authorize('doctors','new')
			authorize('doctors','create')
		end

		it "not authorize doctors [show edit update destroy]" do
			authorize('doctors','show')
			authorize('doctors','edit')
			authorize('doctors','update')
			authorize('doctors','destroy')
		end
	end

	# describe "as a patient" do
		# let(:patient){FactoryGirl.create(:patient)}
		# log_in(patient)
		# subject{ Permission.new(patient)}

		# it { should_not authorize("patients", "index") }
	# 	it 'authorize home [index]' do
	# 		expect(authorize("home","index")).to be_true
	# 	end
	# 	it 'authorize patient [new create show edit update destroy]' do
	# 		expect(authorize("patient","new")).to be_true
	# 		expect(authorize("patient","create")).to be_true
	# 		expect(authorize("patient","show")).to be_true
	# 		expect(authorize("patient","edit")).to be_true
	# 		expect(authorize("patient","update")).to be_true
	# 		expect(authorize("patient","destroy")).to be_true
	# 	end
	# 	it "not authorize patient [index]" do
	# 		expect(authorize("patient", "index")).to
	# 	end
	# end
end