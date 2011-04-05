Factory.define :status do |s|
  s.source "Comment"
  s.sequence(:text) { |t| "#{Faker::Lorem.sentence} #{t}" }
end