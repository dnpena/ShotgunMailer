# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email do
    sender "MyString"
    recipient "MyString"
    subject "MyString"
    answered false
  end
end
