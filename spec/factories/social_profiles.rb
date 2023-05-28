FactoryBot.define do
  factory :social_profile do
    user
    provider { "MyString" }
    uid { "MyString" }
    raw_info { "MyString" }
  end
end
