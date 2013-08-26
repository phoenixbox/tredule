require 'spec_helper'

describe DoctorsController do
	describe "GET#new" do
		it "renders the new template"	do
			get :new
			expect(response).to render_template(:new)
		end

		it "assigns a new Doctor to @doctor" do
			get :new
			expect(assigns(:doctor)).to be_a_new(Doctor)
		end
	end
	describe "GET#show" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			session[:user_email] = @doctor.email
		end
		it "renders the show template" do
			get :show, id: @doctor
			expect(response).to render_template(:show)
		end
		it "assigns the requested doctor to @doctor" do
			get :show, id: @doctor
			expect(assigns(:doctor)).to eq(@doctor)
		end
	end
	describe "GET#edit" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			session[:user_email] = @doctor.email
		end
		it "renders the :edit template" do
			get :edit, id: @doctor
			expect(response).to render_template(:edit)
		end
		it "assigns the requested doctor to @doctor" do
			get :edit, id: @doctor
			expect(assigns(:doctor)).to eq(@doctor)
		end
	end
	describe "POST#create" do
		context "with valid attributes" do
			it "saves a Doctor to the db" do
				expect{
					post :create, doctor: FactoryGirl.attributes_for(:doctor)
				}.to change(Doctor, :count).by 1
			end
			it "redirects to the Doctor show" do
				post :create, doctor: FactoryGirl.attributes_for(:doctor)
				expect(response).to redirect_to(doctor_path(Doctor.last))
			end
		end
		context "with invalid attributes" do
			it "does not save a Doctor to the db" do
				expect{
					post :create, doctor: FactoryGirl.attributes_for(:doctor, email: "")
				}.to change(Doctor, :count).by 0
			end
			it "re-renders the edit template" do
				post :create, doctor: FactoryGirl.attributes_for(:doctor, email: "")
				expect(response).to render_template(:new)
			end
		end
	end
	describe "PUT#update" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor, first_name: 'drake')
			session[:user_email] = @doctor.email
		end
		context "with valid attributes" do
			it "updates the doctor" do
				put :update, id: @doctor, doctor: {first_name: "andrew"}
				@doctor.reload
				expect(@doctor.first_name).to eq "Andrew"
			end
			it "redirects to the doctor show" do
				put :update, id: @doctor, doctor: {first_name: "john"}
				@doctor.reload
				expect(response).to redirect_to(@doctor)
			end
		end
		context "with invalid attributes" do
			# TODO
		end
	end
	describe "DELETE#destroy" do
		before(:each) do
			@doctor = FactoryGirl.create(:doctor)
			session[:user_email] = @doctor.email
		end
		it "deletes the doctor from the database" do
			expect{
				delete :destroy, id: @doctor
				}.to change(Doctor, :count).by -1
		end
		it "redirects to the root_path" do
			delete :destroy, id: @doctor
			expect(response).to redirect_to root_path
		end
	end
end