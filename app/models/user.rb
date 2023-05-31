class User < ApplicationRecord
  authenticates_with_sorcery!

  has_one :social_profile, dependent: :destroy
  has_one :apikey, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
end
