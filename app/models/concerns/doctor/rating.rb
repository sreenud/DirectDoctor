class Doctor
  module Rating
    extend ActiveSupport::Concern

    def star_percentage(number)
      five_ratings = ratings(number)
      if total_reviews.to_f > 0
        ((five_ratings.to_f / total_reviews.to_f) * 100).round
      else
        total_reviews.to_f
      end
    end

    def total_reviews
      reviews.published.count
    end

    def ratings(number)
      reviews.published.where(rating: number)&.count
    end
  end
end
