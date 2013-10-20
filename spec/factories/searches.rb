# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :search do
    verbatim "Example Search"
    terms ["Example", "Search"]
  end
end
