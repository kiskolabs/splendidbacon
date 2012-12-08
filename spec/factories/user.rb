FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@rails.fi" }

  factory :user do
    name "John Doe"
    email { generate(:email) }
    password "12345678"
  end
end
