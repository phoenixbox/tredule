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

	def edit_patient(user, attributes={})
		binding.pry
		log_in(user)
		visit edit_patient_path(@_current_user)
		fill_in :patient_first_name, :with => "Alex"
		fill_in :patient_second_name, :with => user.second_name
		fill_in :patient_email, :with => attributes[:email] || user.email
		fill_in :patient_dob, :with => user.dob
		fill_in :patient_insurance_provider, :with => user.insurance_provider
		fill_in :patient_policy_number, :with => user.policy_number
		fill_in :patient_medical_card_number, :with => user.medical_card_number
		fill_in :patient_password, :with => user.password
		fill_in :patient_password_confirmation, :with => 'secret'
		click_button("Update Profile")
	end
end