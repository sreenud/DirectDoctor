class State < ApplicationRecord
  has_many :locations
  scope :by_code, -> { order(code: :asc) }
  scope :by_name, -> { order(name: :asc) }
end
