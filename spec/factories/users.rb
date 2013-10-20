# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username "Example Name" # require names without spaces?
    email "email@example.com" # validate email format
  end
end
