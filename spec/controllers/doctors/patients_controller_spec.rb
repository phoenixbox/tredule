require 'spec_helper'

describe Doctors::PatientsController do
	describe "GET#index" do
		let(:doctor){FactoryGirl.create(:doctor)}

		before(:each) do
			controller.stub(:current_user => doctor)
		end

		it "renders the index template" do
			get :index, :id => doctor.id
			expect(response).to render_template(:index)
		end
	end
end
# ----- Controller Spec Examples for checking routes -----
# xit "generates the GET#index route" do
# 	assert_generates "/doctors/#{doctor.id}/patients",
#     { :controller => "patients", :action => "index", :doctor_id => doctor.id }
# end


# xit "routes to the index action" do
#   { get: "/doctors/#{doctor.id}/patients" }.
#     should route_to controller: "patients",
#       							action: "index",
#       							doctor_id: "#{doctor.id}"
# end

# xit "hit the index route" do
# 	expect(:get => "/doctors/#{doctor.id}/patients").to route_to(
# 		:controller => "patients",
# 		:doctor_id => doctor.id
# 		)
# end