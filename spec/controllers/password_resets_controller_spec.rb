require 'spec_helper'

describe PasswordResetsController do
		describe "GET#new" do
			context "as a guest" do
				it "renders the new password_resets template" do
					get :new
					expect(response).to render_template(:new)
				end
			end
		end
end