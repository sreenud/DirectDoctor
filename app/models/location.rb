class Location < ApplicationRecord
  # belongs_to :state
  scope :by_name, -> { order(name: :asc) }
  scope :top, -> { order(people: :desc) }
end
