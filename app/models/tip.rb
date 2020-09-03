class Tip < ApplicationRecord
  include ImageUploader::Attachment(:image)

  has_many :topic_tips
  has_many :topics, through: :topic_tips

  scope :latest, -> { order(created_at: :desc) }

  validates :name, :summary, :content, :meta_title, :meta_keywords, :meta_description, presence: true
  validates :slug, uniqueness: true

  enum status: {
    draft: "draft",
    review: "review",
    published: "published",
    archive: "archive",
  }

  before_create do
    self.code = SecureRandom.hex
  end
end
