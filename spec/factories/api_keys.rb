FactoryBot.define do
  factory :apikey do
    user
    sequence(:access_token) { |n| "MyString#{n}" }
    expires_at { 1.weeks.since }
  end
end
