FactoryBot.define do
  factory :followed_user do
    sequence(:twitter_id) { |n| "98765" + n.to_s }
    official_account { false }
  end
end
