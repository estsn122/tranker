FactoryBot.define do
  factory :point_log do
    sequence(:twitter_id) { |n| "98765" + n.to_s }
    points { 0 }
    aggregated_on { Date.today }
  end
end
