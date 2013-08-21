module AuthMacros
	def log_in(user)
		@_current_user = user
		visit root_path
		fill_in :email, :with => user.email
		fill_in :password, :with => user.password
		click_button "Log-In!"
		expect(page).to have_link("Logout")
	end

	def current_user
		@_current_user
	end
end