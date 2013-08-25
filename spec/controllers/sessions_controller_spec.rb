require 'spec_helper'

describe SessionsController do
	describe 'POST#Create' do
		before(:each) do
			@patient = FactoryGirl.create(:patient)
			@doctor = FactoryGirl.create(:doctor)
		end
		context 'with valid attributes' do
			it "on patient login re-directs to the patient show" do
				post :create, {email: @patient.email, password: @patient.password}
				expect(response).to redirect_to(patient_path(@patient))
			end
			it "on doctor login re-directs to the doctor show" do
				post :create, {email: @doctor.email, password: @doctor.password}
				expect(response).to redirect_to(doctor_path(@doctor))
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