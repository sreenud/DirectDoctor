class Doctor
  module Rating
    extend ActiveSupport::Concern

    def star_percentage(number)
      five_ratings = ratings(number)
      ((five_ratings.to_f / total_reviews.to_f) * 100).round
    end

    def total_reviews
      reviews.count
    end

    def ratings(number)
      reviews.where(rating: number)&.count
    end
  end
end
