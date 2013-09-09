require 'spec_helper'

describe Doctor do
  subject do
  	FactoryGirl.create(:doctor)
  end

  it "subject should be valid" do
  	expect(subject).to be_valid
  end

  it { should have_many(:patients).through(:doctors_patients) }

  it "invalid attributes is not valid" do
  	subject.email = ""
  	expect(subject).to_not be_valid
  end

  it "subject with associated patient" do
  	p = FactoryGirl.create(:patient)
  	subject.patients<<p
  	expect(subject.patients.count).to eq 1
  end
end
