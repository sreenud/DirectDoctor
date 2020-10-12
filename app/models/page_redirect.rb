class PageRedirect < ApplicationRecord
  validates :old, :new, :redirect_code, :comments, presence: true

  scope :latest, -> { order(created_at: :desc) }

  enum codes: {
    "301": "301",
    "302": "302",
    "404": "404",
  }
end
