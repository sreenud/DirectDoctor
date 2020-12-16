class Review < ApplicationRecord
  belongs_to :doctor

  validates :rating, :title, :name, :email, :review,
    :treated_by_doctor, :will_you_recommend, :anonymous, presence: true

  scope :published, -> { where(status: "published") }

  after_commit do
    ReviewData.refresh
  end

  def display_date
    created_at.strftime("%B %d, %Y")
  end
end
