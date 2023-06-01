class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :social_profile, dependent: :destroy
  has_many :apikeys, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
end
