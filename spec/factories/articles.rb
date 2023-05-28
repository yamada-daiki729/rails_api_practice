FactoryBot.define do
  factory :article do
    user
    sequence(:title) { |n| "MyString#{n}" }
    sequence(:contents) { |n| "MyText#{n}" }
    status { Article.statuses.keys.first }
  end
end
