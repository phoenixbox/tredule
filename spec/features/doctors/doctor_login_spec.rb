require 'spec_helper'

feature "doctor login:" do
	let(:doctor){FactoryGirl.create(:doctor)}
	context "with valid attributes" do
		it "needs to login to visit doctor show" do
			visit doctor_path(doctor)
			expect(page).to_not have_content("Logged in as")
			expect(page).to have_selector('form.login-form')
		end

		it "doctor can login" do
			log_in(doctor)
			expect(page).to have_link("Logout")
			expect(page).to have_content(doctor.first_name)
		end
	end
	context "with invalid attributes" do
		it "doctor cant login" do
			log_in(doctor, email: "wrong@example.com")
			expect(page).to have_content("Tredule")
		end
	end
end