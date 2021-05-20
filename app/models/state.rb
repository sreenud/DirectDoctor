class State < ApplicationRecord
  geocoded_by :name, latitude: :lat, longitude: :lng
  reverse_geocoded_by :lat, :lng

  has_many :locations
  scope :by_code, -> { order(code: :asc) }
  scope :by_name, -> { order(name: :asc) }

  def self.valid_state(state_name)
    State.find_by_name(state_name)
  end
end
