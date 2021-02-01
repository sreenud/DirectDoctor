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
    render(DoctorComponent.with_collection(@doctors))
  end

  def render_job_cards
    render(JobComponent.with_collection(@doctors, reviews_data: @reviews_data))
  end

  def render_special_near_field
    hidden_field_tag(:near, @special_near)
  end

  def special_speciality_value
    @special_speciality
  end

  def max_distance
    @max_distance ||= @doctors.map(&:distance).max
  end
end
