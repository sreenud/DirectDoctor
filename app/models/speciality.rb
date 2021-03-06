class Speciality < ApplicationRecord
  has_many :speciality_aliases
  has_many :doctors
  scope :latest, -> { order(created_at: :desc) }
  scope :dpc, -> { where("name LIKE '%DPC%'") }
  scope :cm, -> { where("name LIKE '%Concierge%'") }

  validates :code, :name, presence: true
  accepts_nested_attributes_for :speciality_aliases, allow_destroy: true

  before_save :generate_slug

  def practice_style
    if name.split(" ").include?("Concierge")
      "cm"
    else
      "dpc"
    end
  end

  private

  def generate_slug
    return if slug.present?

    self.slug = name.parameterize
  end
end
