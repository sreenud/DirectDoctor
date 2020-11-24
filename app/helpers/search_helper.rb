module SearchHelper
  def render_star_rating(rating, **props)
    render(StarRatingComponent.new(rating: rating, **props))
  end

  def doctor_pins
    @doctors.map { |doc| doctor_pin_string(doc) }.join('|')
  end

  def doctor_pin_string(doctor)
    [:lat, :lng, :price, :id].map { |a| doctor.send(a) || '' }.join(',')
  end

  def render_doctor_cards
    @doctors.map do |doc|
      render(DoctorComponent.new(doctor: doc))
    end.join('').html_safe
  end

  def max_distance
    @max_distance ||= @doctors.map(&:distance).max
  end
end
