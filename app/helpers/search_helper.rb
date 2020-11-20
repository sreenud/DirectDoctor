module SearchHelper
  def render_star_rating(rating, **props)
    custom_class = props.delete(:class)
    filled_stars = rating.to_f.round
    empty_stars = 5 - filled_stars
    content_tag(:div, class: "flex items-center #{custom_class}", **props) do
      filled_stars.times { concat(star) }
      empty_stars.times { concat(star(variant: 'empty')) }
    end
  end

  private

  def star(variant: 'filled')
    fill_class = variant == 'filled' ? 'text-doctor-yellow' : 'text-gray-400'
    content_tag(:svg, class: "w-4 h-4 fill-current #{fill_class}") do
      concat(star_shape)
    end
  end

  def star_shape
    tag.path(
      d: 'M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z'
    )
  end
end
