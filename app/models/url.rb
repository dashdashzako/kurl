class Url < ApplicationRecord
  validates :original, presence: true
  validates :short, presence: true
end
