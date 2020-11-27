class StarRatingComponent < ViewComponent::Base
  def initialize(rating:, **props)
    @props = props

    @filled_stars = rating.to_f.round
    @empty_stars = 5 - @filled_stars
  end
end
