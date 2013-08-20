require 'spec_helper'

feature 'Patient logs-in' do
	let(:user){FactoryGirl.create(:patient)}
	xit "through home page" do
		visit root_path
		login user
		expect(page).to have_content("Welcome, Shane")
	end
end