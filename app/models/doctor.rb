class Doctor < ApplicationRecord
  include ImageUploader::Attachment(:image)

  attr_accessor :cost

  scope :latest, -> { order(created_at: :desc) }

  enum status: {
    draft: "draft",
    review: "review",
    published: "published",
    archive: "archive",
  }

  enum practice: {
    dpc: "DPC",
    concierge: "Concierge Practice",
  }

  enum speciality: {
    d: "D",
    c: "C",
    cac: "CAC",
    cal: "CAL",
    can: "CAN",
  }
end
