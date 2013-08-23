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
			doctor = FactoryGirl.create(:doctor)
		end
	end
end