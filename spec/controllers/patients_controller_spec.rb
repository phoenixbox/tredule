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
			session[:user_id] = patient.id
			get :show, id: patient
			expect(assigns(:patient)).to eq(patient)
		end

		it "renders the show template" do
			patient = FactoryGirl.create(:patient)
			session[:user_id] = patient.id
			get :show, id: patient.id
			expect(response).to render_template(:show)
		end
	end

	describe 'GET#edit' do
		it "assigns the requested patient to @patient" do
			patient = FactoryGirl.create(:patient)
			session[:user_id] = patient.id
			get :edit, id: patient.id
			expect(assigns(:patient)).to eq(patient)
		end

		it "renders the edit template" do
			patient = FactoryGirl.create(:patient)
			session[:user_id] = patient.id
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

			it 're-renders the create template' do
				post :create, patient: FactoryGirl.attributes_for(:invalid_patient)
				expect(response).to render_template(:new)
			end
		end
	end

	describe 'PUT#update' do
		before(:each) do
			@patient = FactoryGirl.create(:patient, first_name: 'Steve')
		end

		it 'locates the requested @patient' do
			session[:user_id] = @patient.id
			put :update, id: @patient, patient: FactoryGirl.attributes_for(:patient)
			expect(assigns(:patient)).to eq(@patient)
		end

		context "valid attributes" do
			it 'changes @patient attributes in the database' do
				session[:user_id] = @patient.id
				put :update, id: @patient, patient: FactoryGirl.attributes_for(:patient, first_name: 'Simon')
				@patient.reload
				expect(@patient.first_name).to eq('Simon')
			end

			it 'redirects to the updated patient' do
				session[:user_id] = @patient.id
				put :update, id: @patient, patient: FactoryGirl.attributes_for(:patient)
				@patient.reload
				expect(response).to redirect_to(@patient)
			end
		end

		context "invalid attributes" do
			it "does not change the @patient attributes" do
				session[:user_id] = @patient.id
				put :update, id: @patient, patient: FactoryGirl.attributes_for(:invalid_patient)
				@patient.reload
				expect(@patient.first_name).to eq('Steve')
			end

			it 're-renders the edit template' do
				session[:user_id] = @patient.id
				put :update, id: @patient, patient: FactoryGirl.attributes_for(:invalid_patient)
				expect(response).to render_template :edit
			end
		end
	end

	describe 'DELETE#destroy' do
		before(:each) do
			@patient = FactoryGirl.create(:patient)
			session[:user_id] = @patient.id
		end

		it 'deletes the patient' do
			expect{
				delete :destroy, id: @patient
			}.to change(Patient, :count).by(-1)
		end

		it "redirects to the root path" do
			delete :destroy, id: @patient
			expect(response).to redirect_to root_path
		end
	end
end