class ApiKey < ApplicationRecord
  belongs_to :user

  validates :access_token, presence: true, uniqueness: true

  scope :still_valid, -> { where('expires_at > ?', Time.current) }
end
