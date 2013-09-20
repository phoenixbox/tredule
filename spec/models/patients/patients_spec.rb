require 'spec_helper'

describe Patient do
	subject do
		FactoryGirl.create(:patient, email: "uniqueemail1@email.com" )
	end

	it { should have_db_column(:email) }
	it { should have_db_column(:auth_token) }
	it { should have_many(:doctors).through(:doctors_patients)}
	it { should have_many(:invites) }

	it 'subject should be valid' do
		expect(subject).to be_valid
	end

	it 'subject not valid without an email' do
		subject.email = ""
		expect(subject).to_not be_valid
	end

	it "subject with associated doctor" do
		d = FactoryGirl.create(:doctor)
		subject.doctors<<d
		expect(subject.doctors.count).to eq 1
	end
end