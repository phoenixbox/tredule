require 'spec_helper'

describe Patient do
	subject do
		FactoryGirl.create(:patient)
	end

	it 'subject should be valid' do
		expect(subject).to be_valid
	end

	it 'subject should have a mobile field' , focus: true do
		expect(subject.mobile).to eq('01234567')
	end
end