class Topic < ApplicationRecord
  has_many :topic_tips
  has_many :tips, through: :topic_tips

  scope :latest, -> { order(created_at: :desc) }

  validates :name, :content, presence: true
end
