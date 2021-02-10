class Job < ApplicationRecord
  belongs_to :doctor

  validates :title, :description, :desired_skills, :doctor_id, :specialities,
    :experience, :salary, :sign_on_bonus, :hours, presence: true

  validate :custom_board_certification

  scope :latest, -> { order(created_at: :desc) }

  def posted_on
    created_at.strftime("%b %d, %y")
  end

  def custom_board_certification
    if board_certification.blank?
      errors.add(:base, "Board Eligible or Board Certified can't be blank")
    end
  end
end
