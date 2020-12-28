class Job < ApplicationRecord
  belongs_to :doctor

  scope :latest, -> { order(created_at: :desc) }
end
