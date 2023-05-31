FactoryBot.define do
  factory :apikey do
    user { nil }
    access_token { "MyString" }
    expires_at { "2023-05-31 10:14:35" }
  end
end
