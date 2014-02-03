# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :conversation do
    read false
    answered false
    subject "MyString"
  end
end
