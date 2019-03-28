class Url < ApplicationRecord
  validates :original, format: { with: /\Ahttps?:\/\/[a-z0-9]{2,}\.[a-z]{2,}.*\z/, message: "given url isn't well formatted" }
  validates :short, length: { is: 6 }
  validates :expires_at, presence: true
end
