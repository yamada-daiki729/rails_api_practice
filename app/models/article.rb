class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :status, presence: true

  enum status: { draft: 0, in_review: 10, published: 20, archived: 30 }
end
