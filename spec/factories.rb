Factory.define :user do |u|
  u.name "John Doe"
  u.sequence(:email) { |n| "user-#{n}@rails.fi" }
  u.password "123456"
end