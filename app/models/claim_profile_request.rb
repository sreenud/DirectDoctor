class ClaimProfileRequest < ApplicationRecord
  include DocumentUploader::Attachment(:document)

  attr_accessor :user_type

  belongs_to :user

  validates :profile_name, :user_type, :document, presence: true, if: :doctor?

  scope :latest, -> { order(created_at: :desc) }

  def doctor?
    user_type == 'doctor'
  end

  def posted_on
    created_at.strftime("%b %d, %Y")
  end
end
