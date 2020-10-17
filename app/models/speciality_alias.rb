class SpecialityAlias < ApplicationRecord
  belongs_to :speciality

  validates :name, presence: true
end
