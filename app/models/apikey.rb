class Apikey < ApplicationRecord
  belongs_to :user

  validates :access_token, presence: true, uniqueness: true

  scope :still_valid, -> { where('expires_at > ?', Time.now) }
end
