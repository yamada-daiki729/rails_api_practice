FactoryBot.define do
  factory :api_key do
    user { nil }
    access_token { "MyString" }
    expires_at { "2020-04-16 21:27:18" }
  end
end
