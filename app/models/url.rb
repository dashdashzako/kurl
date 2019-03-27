class Url < ApplicationRecord
  validates :original, presence: true
  validates :short, presence: true
  validates :expires_at, presence: true
end
