class ClaimProfileRequest < ApplicationRecord
  include DocumentUploader::Attachment(:document)

  attr_accessor :user_type, :name, :email
  has_secure_token :request_token

  belongs_to :user
  has_many :claim_profile_comments

  accepts_nested_attributes_for :claim_profile_comments, reject_if: :all_blank, allow_destroy: true

  validates :user_type, :document, presence: true, if: :doctor?
  validates :user_type, :name, :email, presence: true, if: :admin?

  scope :latest, -> { order(created_at: :desc) }

  def doctor?
    user_type == 'doctor'
  end

  def admin?
    user_type == 'admin'
  end

  def posted_on
    created_at.strftime("%b %d, %Y")
  end

  def doctor_name
    if profile_name.present?
      if profile_name.split('<').length > 1
        profile_name.split('<')&.first&.strip
      elsif profile_name.split('N/A').length
        profile_name.split('N/A')&.first&.strip
      elsif profile_name.split('n/a').length
        profile_name.split('n/a')&.first&.strip
      else
        profile_name
      end
    end
  end

  def claim_profile_comments_count
    claim_profile_comments.select do |claim_profile_comment|
      claim_profile_comment.is_read == false
    end.size
  end
end
