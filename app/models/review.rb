class Review < ApplicationRecord
  belongs_to :doctor

  validates :rating, :title, :name, :email, :review,
    :treated_by_doctor, :will_you_recommend, :anonymous, presence: true

  scope :published, -> { where(status: "published") }
  scope :draft, -> { where(status: "draft") }
  scope :latest, -> { order(created_at: :desc) }
  scope :admin_list, -> { where(status: ["published", "draft", "archive"]) }


  after_commit :refresh_view, on: [:update]

  enum status: {
    draft: "draft",
    published: "published",
    archive: "archive",
    trash: "trash",
  }

  def display_date
    created_at.strftime("%B %d, %Y")
  end

  private

  def refresh_view
    ReviewData.refresh if published?
  end
end
