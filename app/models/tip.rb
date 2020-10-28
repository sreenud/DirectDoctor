class Tip < ApplicationRecord
  include ImageUploader::Attachment(:image)
  acts_as_taggable_on :tags

  # has_many :topic_tips
  belongs_to :topic

  scope :latest, -> { order(created_at: :desc) }
  scope :published, -> { where(status: 'published') }

  validates :name, :summary, :content, :meta_title, :meta_description, presence: true
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

  def readable_published_date
    created_at.strftime("%B %d, %Y")
  end

  def next
    Tip.where("id > ?", id).published.order("id ASC").first || Tip.published.first
  end

  def previous
    Tip.where("id < ?", id).published.order("id DESC").first || Tip.published.first
  end
end
