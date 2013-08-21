require 'spec_helper'

describe SessionsController do
	describe 'POST#Create' do
		context 'with valid attributes' do
			it "renders the patient show when logged-in with valid attributes" do
				patient = FactoryGirl.create(:patient, email: "banana@banana.com")
				post :create, {email: patient.email, password: patient.password}
				expect(response).to redirect_to(patient_path(patient))
			end
		end
		context 'with invalid attributes' do
		end
	end
end