FactoryGirl.define do
  sequence(:email) { |n| "user-#{n}@rails.fi" }

  factory :user do
    name "John Doe"
    email { generate(:email) }
    password "123456"
  end
end
