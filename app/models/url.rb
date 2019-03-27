class Url < ApplicationRecord
  validates :original, :short, :expires_at, presence: true
end
