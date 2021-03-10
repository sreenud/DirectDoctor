class ClaimProfileComment < ApplicationRecord
  belongs_to :user
  belongs_to :claim_profile_request

  validates :comment, presence: true
end
