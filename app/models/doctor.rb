class Doctor < ApplicationRecord
  include ImageUploader::Attachment(:image)

  attr_accessor :cost, :experience

  scope :latest, -> { order(created_at: :desc) }

  enum status: {
    draft: "draft",
    review: "review",
    published: "published",
    archive: "archive",
  }

  enum practice: {
    dpc: "Direct Primary Care",
    concierge: "Concierge",
    both: "Both",
  }

  enum patients_in_panel: {
    "0-50": "<50 patients",
    "51-200": "51 - 200 patients",
    "201-500": "201 - 500 patients",
    "501-1000": "501 - 1000 patients",
    "1000": ">1000 patients",
  }

  enum experience: {
    "0-5": "0 - 5 years",
    "6-10": "6 - 10 years",
    "11-20": "11 - 20 years",
    "20": ">20 years",
  }

  enum holistic_medicine: {
    "yes": "Yes",
    "no": "No",
  }

  def self.first_experience
    experiences&.first&.first
  end
end
