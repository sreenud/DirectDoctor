class City < ApplicationRecord
  geocoded_by :name, latitude: :lat, longitude: :lng
  reverse_geocoded_by :lat, :lng
  after_validation :location_attributes

  validates :name, presence: true
  validates :name, uniqueness: true

  private

  def location_attributes
    self.slug = name.parameterize unless slug.present?
    geocode unless lat.present? && lng.present?
  end
end
