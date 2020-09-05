class Topic < ApplicationRecord
  include ImageUploader::Attachment(:image)
  acts_as_taggable_on :tags

  has_many :topic_tips
  has_many :tips, through: :topic_tips

  scope :latest, -> { order(created_at: :desc) }

  validates :name, :summary, :content, :meta_title, :meta_keywords, :meta_description, presence: true
  validates :slug, uniqueness: true

  enum status: {
    draft: "draft",
    review: "review",
    published: "published",
    archive: "archive",
  }
end
