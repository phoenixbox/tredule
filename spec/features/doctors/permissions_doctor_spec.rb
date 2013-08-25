require 'spec_helper'

feature "Doctor permissions" do
	context "un-authorized" do
		let(:doctor){FactoryGirl.create(:doctor)}
		let(:patient){FactoryGirl.create(:patient)}
		it "cannot visit patient's page" do
			log_in(doctor)
			visit patient_path(patient)
			expect(page).to have_content("You are not authorized to visit this page" )
		end
	end
end