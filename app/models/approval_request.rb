class ApprovalRequest < ApplicationRecord
  belongs_to :user, foreign_key: 'request_user_id', class_name: 'User'

  enum status: { pending: 0, cancelled: 1, approved: 2, rejected: 3 }
  scope :latest, -> { order(created_at: :desc) }

  def requested_on
    requested_at.strftime("%b %d, %Y")
  end
end
