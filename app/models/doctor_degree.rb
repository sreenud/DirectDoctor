class DoctorDegree < ApplicationRecord
  scope :latest, -> { order(created_at: :desc) }

  validates :code, :name, presence: true
end
