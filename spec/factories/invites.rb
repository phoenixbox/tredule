# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invite do
    invited_email "MyString"
    inviteable_id 1
    inviteable_type "MyString"
    state "MyString"
  end
end
