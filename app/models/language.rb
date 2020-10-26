class Language < ApplicationRecord
  scope :latest, -> { order(created_at: :desc) }

  validates :name, presence: true
end
