class Topic < ApplicationRecord
  include ImageUploader::Attachment(:image)
  acts_as_taggable_on :tags

  has_many :topic_tips
  has_many :tips, through: :topic_tips
  belongs_to :category, optional: true

  scope :latest, -> { order(created_at: :desc) }
  scope :popular, -> { where(is_popular: true) }
  scope :published, -> { where(status: 'published') }

  validates :name, :summary, :content, :meta_title, :read_time, :meta_description, presence: true
  validates :slug, uniqueness: true

  enum status: {
    draft: "draft",
    review: "review",
    published: "published",
    archive: "archive",
  }

  def readable_published_date
    created_at.strftime("%B %d, %Y")
  end

  def next
    Topic.where("id > ?", id).order("id ASC").first || Topic.first
  end

  def previous
    Topic.where("id < ?", id).order("id DESC").first || Topic.first
  end
end
