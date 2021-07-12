class Faq < ApplicationRecord
  scope :latest, -> { order(created_at: :desc) }
  scope :published, -> { where(status: "published") }

  validates :name, :content, :meta_title, :meta_description, presence: true
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
end
