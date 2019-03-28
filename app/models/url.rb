require 'securerandom'

class Url < ApplicationRecord
  URL_REGEX = /\Ahttps?:\/\/[-a-zA-Z0-9@:%\._\+~#\=]{2,256}\.[a-z]{2,6}[-a-zA-Z0-9@:%_\+.~#?&\/=]*\z/

  validates :original, format: { with: URL_REGEX, message: "given url isn't well formatted" }
  validates :short, length: { is: 6 }
  validates :expires_at, presence: true

  before_validation :set_short_code, on: :create
  before_validation :set_expires_at, on: :create

  def set_short_code
    self.short = SecureRandom.hex(3)
  end

  def set_expires_at
    self.expires_at = 3.days.from_now
  end
end
