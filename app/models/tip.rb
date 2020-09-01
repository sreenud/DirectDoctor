class Tip < ApplicationRecord
  has_many :topic_tips
  has_many :topics, through: :topic_tips
end
