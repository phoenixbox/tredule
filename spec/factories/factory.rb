FactoryGirl.define do
  factory :patient do
    first_name 'shane'
    second_name 'rogers'
    email "patient@example.com"
    mobile '01234567'
    dob '01/01/1980'
    insurance_provider 'VHI'
    policy_number '12345'
    medical_card_number ''
    auth_token '5QGbbHJvkwD0d6xfMfORfQ'
    password 'secret'
    factory :invalid_patient do
      email "!bah*&#.com"
    end
  end

  factory :doctor do
    first_name 'raphael'
    second_name 'weiner'
    mobile '01234567'
    email "doctor@example.com"
    password 'secret'
    speciality 'orthopedics'
    auth_token 'rcLlprAdAhWzpGDsjiYpWA'
    medical_school 'harvard'
    password_reset_token ''
    password_reset_at ""
    factory :invalid_doctor do
      email "!bah*&#.com"
    end
  end
  # factory :invite do
  #   invited_email "MyString"
  #   inviteable_id 1
  #   inviteable_type "MyString"
  #   state "MyString"
  # end
end