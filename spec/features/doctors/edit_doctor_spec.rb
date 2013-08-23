require 'spec_helper'

feature 'Doctor edits their details' do

	context "with valid attributes" do
		let(:doctor){FactoryGirl.create(:doctor)}

		it "updates the doctor" do
			visit(doctor_path(doctor))
			expect(page).to have_link("Profile")
			click_link("Profile")
			within(:css, "form#edit-doctor-form"){
				fill_in :doctor_first_name, :with => 'simon'
				click_button("Update!")
			}
			expect(page).to have_content("Simon")
		end
	end
end