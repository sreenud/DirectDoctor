class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  validates :full_name, :email, presence: true

  def assign_default_role
    add_role(:patient) if roles.blank?
  end

  def roles_string
    roles.pluck(:name).map(&:humanize).join(", ")
  end
end
