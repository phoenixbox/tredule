require 'spec_helper'

feature 'delete Patient account' do
	before(:each){
		@patient = FactoryGirl.create(:patient)
	}
	it ":patient can see the delete link and delete their account" do
		log_in(@patient)
		visit edit_patient_path(@patient)
		expect(page).to have_button("Delete Account")
		click_button("Delete Account")
		expect(page).to have_content("Tredule")
	end
end