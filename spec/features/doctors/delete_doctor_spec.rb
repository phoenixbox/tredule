require 'spec_helper'

feature 'delete Doctor account' do
	before(:each){
		@doctor = FactoryGirl.create(:doctor)
	}
	it ":Doctor can see the delete link and delete their account" do
		visit edit_doctor_path(@doctor)
		expect(page).to have_button("Delete Account")
		click_button("Delete Account")
		expect(page).to have_content("Tredule")
	end
end