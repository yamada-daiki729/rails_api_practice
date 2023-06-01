FactoryBot.define do
  factory :comment do
    user
    sequence(:contents) { |n| "MyText#{n}" }
  end
end
