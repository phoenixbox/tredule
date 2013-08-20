require 'spec_helper'

describe PatientsController do
	describe 'GET#new' do
		it "renders the new template" do
			get :new
			expect(response).to render_template(:new)
		end

		it 'assigns a new Patient to @patient', focus: true do
			get :new
			expect(assigns(:patient)).to be_a_new(Patient)
		end
	end

	describe 'GET#show' do
		it 'assigns the requested patient to @patient' do
			patient = FactoryGirl.create(:patient)
			get :show, id: patient
			expect(assigns(:patient)).to eq(patient)
		end

		it "renders the show template" do
			patient = FactoryGirl.create(:patient)
			get :show, id: patient.id
			expect(response).to render_template(:show)
		end
	end

	describe 'GET#edit' do
		it "assigns the requested patient to @patient" do
			patient = FactoryGirl.create(:patient)
			get :edit, id: patient.id
			expect(assigns(:patient)).to eq(patient)
		end

		it "renders the edit template" do
			patient = FactoryGirl.create(:patient)
			get :edit, id: patient
			expect(response).to render_template(:edit)
		end
	end

	describe 'POST#create' do
		context 'with valid attributes' do
			it 'saves a new patient in the database' do
				expect{
					post :create, patient: FactoryGirl.attributes_for(:patient)
					}.to change(Patient, :count).by(1)
			end

			it "redirects to the patient show page" do
				post :create, patient: FactoryGirl.attributes_for(:patient)
				expect(response).to redirect_to(Patient.last)
			end
		end

		context 'with invalid attributes' do
			it 'does not create a new patient in the database' do
				expect{
					post :create, patient: FactoryGirl.attributes_for(:invalid_patient)
				}.to_not change(Patient, :count).by(1)
			end
		end
	end
end