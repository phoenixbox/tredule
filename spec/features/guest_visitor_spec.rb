require 'spec_helper'

feature 'guest visits the site' do
	it 'can see the header copy' do
		visit root_path
		within(:css, 'header#banner'){
			expect(page).to have_content('Tredule')
		}
	end

	it 'can sign-up to be a patient', focus: true do
		visit root_path
		within(:css, 'div#patient-signup'){
				expect(page).to have_link("Patient")
				click_link("Patient")
			}
			expect(page).to have_css('form#new-patient-form')
	end

	xit "can sign-up to be a doctor" do
		visit root_path
		within(:css, 'div#doctor-signup'){
			expect(page).to have_link("doctor")
		}
	end
end