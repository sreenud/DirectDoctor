class State < ApplicationRecord
  geocoded_by :name, latitude: :lat, longitude: :lng
  reverse_geocoded_by :lat, :lng

  has_many :locations
  scope :by_code, -> { order(code: :asc) }
  scope :by_name, -> { order(name: :asc) }
end
