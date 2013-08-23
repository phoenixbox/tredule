require 'spec_helper'

describe Patient do
	subject do
		FactoryGirl.create(:patient)
	end

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