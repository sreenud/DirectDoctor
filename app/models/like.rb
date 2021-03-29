class Like < ApplicationRecord
  belongs_to :user
  belongs_to :doctor

  scope :latest, -> { order(created_at: :desc) }
end
