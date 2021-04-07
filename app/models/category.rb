class Category < ApplicationRecord
  has_many :topics

  scope :active, -> { where(status: "active") }
  scope :latest, -> { order(created_at: :desc) }
end
