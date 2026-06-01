class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :creators, dependent: :destroy
  has_many :writings, dependent: :destroy
  has_many :chapters, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
