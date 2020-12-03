class StarRatingComponent < ViewComponent::Base
  def initialize(rating:, **props)
    @props = props

    @filled_stars = rating.to_f.round
    @empty_stars = 5 - @filled_stars

    @height = @props[:height].present? ? @props[:height] : '4'
    @width = @props[:width].present? ? @props[:width] : '4'
  end
end
