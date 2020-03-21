FactoryBot.define do
  factory :ranker do
    sequence(:twitter_id) { |n| "98765" + n.to_s }
    points { 0 }
    official { false }
  end
end
