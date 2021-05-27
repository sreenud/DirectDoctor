class NewsLetter < ApplicationRecord
  validates :email, presence: true
end
