class ClaimProfileRequest < ApplicationRecord
  include DocumentUploader::Attachment(:document)

  attr_accessor :user_type, :name, :email

  belongs_to :user


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
end
