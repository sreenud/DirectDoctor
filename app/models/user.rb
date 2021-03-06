class User < ApplicationRecord
  include ProfilePicUploader::Attachment(:image)

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :twitter, :linkedin]

  has_many :social_connects, dependent: :destroy
  has_many :approval_requests
  has_one :doctor, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one :claim_profile_request, dependent: :destroy

  after_create :assign_default_role

  validates :full_name, :email, presence: true

  def assign_default_role
    add_role(:guest) if roles.blank?
  end

  def roles_string
    roles.pluck(:name).map(&:humanize).join(", ")
  end

  def likes?(doctor)
    doctor.likes.where(user_id: id).any?
  end

  def has_role?(role)
    roles.any? { |k| k.name == role }
  end
end
