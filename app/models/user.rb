class User < ApplicationRecord
  include ProfilePicUploader::Attachment(:image)

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  has_many :social_connects

  after_create :assign_default_role

  validates :full_name, :email, presence: true

  def assign_default_role
    add_role(:guest) if roles.blank?
  end

  def roles_string
    roles.pluck(:name).map(&:humanize).join(", ")
  end
end
