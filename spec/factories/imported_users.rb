FactoryBot.define do
  factory :imported_user do
    sequence(:twitter_id) { |n| "12345" + n.to_s }
  end
end