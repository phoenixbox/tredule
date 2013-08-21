require 'spec_helper'

describe SessionsController do
	describe 'POST#Create' do
		context 'with valid attributes' do
			it "rendirects the patient show when logged-in with valid attributes" do
				patient = FactoryGirl.create(:patient)
				post :create, {email: patient.email, password: patient.password}
				expect(response).to redirect_to(patient_path(patient))
			end
		end
		context 'with invalid attributes' do
			it "re-renders the index page" do
				patient = FactoryGirl.create(:patient)
				post :create, {email: patient.email, password: "banana"}
				expect(response).to redirect_to(root_path)
			end
		end
	end
end