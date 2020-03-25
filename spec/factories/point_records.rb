FactoryBot.define do
  factory :point_record do
    sequence(:twitter_id) { |n| "98765" + n.to_s }
    points { 0 }
    recorded_on { Date.today }
  end
end
