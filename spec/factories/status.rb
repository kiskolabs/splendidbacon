FactoryGirl.define do
  sequence(:lorem) { |t| "#{Faker::Lorem.sentence} #{t}" }

  factory :status do
    source "Comment"
    text { generate(:lorem) }
  end
end
