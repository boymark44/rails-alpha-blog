class Article < ApplicationRecord
  # Adding validations to our article model
  validates :title, presence: true, length: {minimum: 6, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
end
