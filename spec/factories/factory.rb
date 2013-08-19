FactoryGirl.define do
  factory :patient do
    first_name 'shane'
  	second_name 'rogers'
  	email
	  mobile '01234567'
    dob '01/01/1980'
    insurance_provider 'VHI'
    policy_number '12345'
    medical_card_number ''
  	password 'secret'
  end

  sequence :email do |n|
    "unique_email#{n}@example.com"
  end
end