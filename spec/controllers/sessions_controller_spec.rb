require 'spec_helper'

describe SessionsController do
	describe 'POST#Create' do
		before(:each) do
			@patient = FactoryGirl.create(:patient)
		end
		context 'with valid attributes' do
			it "rendirects the patient show when logged-in with valid attributes" do
				post :create, {email: @patient.email, password: @patient.password}
				expect(response).to redirect_to(patient_path(@patient))
			end
		end
		context 'with invalid attributes' do
			it "re-renders the index page" do
				post :create, {email: @patient.email, password: "banana"}
				expect(response).to redirect_to(root_path)
			end
		end
	end

	describe "DELETE#destroy" do
		it "destroys the current session" do
			patient = FactoryGirl.create(:patient)
			session[:user_id] = patient.id
			delete :destroy, id: patient
			expect(response).to redirect_to(root_path)
		end
	end
end