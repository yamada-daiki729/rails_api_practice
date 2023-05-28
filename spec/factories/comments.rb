FactoryBot.define do
  factory :comment do
    user
    article
    sequence(:contents) { |n| "Mycontents#{n}" }
  end
end
