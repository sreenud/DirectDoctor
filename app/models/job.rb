class Job < ApplicationRecord
  belongs_to :doctor

  validates :name, :doctor_id, :specialities, :board_certification,
  :experience, :salary, :sign_on_bonus, :hours, presence: true

  scope :latest, -> { order(created_at: :desc) }
end
