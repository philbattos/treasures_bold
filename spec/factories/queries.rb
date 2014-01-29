# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :query do
    verbatim "Example Query"
    terms ["Example", "Query"]
  end
end
