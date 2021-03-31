class DoctorTestimonial < ApplicationRecord
  belongs_to :given_to, foreign_key: "testimonial_to", class_name: 'Doctor'
  belongs_to :given_by, foreign_key: "testimonial_by", class_name: 'Doctor'

  scope :latest, -> { order(created_at: :desc) }

  def display_date
    created_at.strftime("%B %d, %Y")
  end
end
