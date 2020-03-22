FactoryBot.define do
  factory :followed_user do
    sequence(:twitter_id) { |n| "345678" + n.to_s }
    truncation { false }
  end
end
