class User < ApplicationRecord
  # Add the before_save callback to downcase the email
  before_save { self.email = email.downcase }

  # Add the one_to_many relationship
  has_many :articles

  # Add the validations to the model attributes (username, email)
  validates :username, presence: true, uniqueness: true, length: {minimum: 3, maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, length: {maximum: 105}, format: {with: VALID_EMAIL_REGEX}
end
