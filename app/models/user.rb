class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { in: 3..20 }
  validates_length_of :password, in: 6..20, on: :create

  def as_json(options = {})
    super(options.merge({ except: %i[password_digest updated_at] }))
  end
end
