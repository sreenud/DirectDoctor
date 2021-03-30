class ClaimProfileComment < ApplicationRecord
  include DocumentUploader::Attachment(:document)

  belongs_to :user
  belongs_to :claim_profile_request

  # validates :comment, presence: true

  default_scope { order(created_at: :asc) }

  def display_date
    created_at.strftime("%B %d, %Y")
  end

end
