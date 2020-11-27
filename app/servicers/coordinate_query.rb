module CoordinateQuery
  attr_reader :latitude, :longitude, :radius

  # accepts latitude, longitude and radius for searching by given radius range
  def within_range(lat:, lng:, radius:)
    generator = build_generator(lat.to_f, lng.to_f)
    query(generator, radius.to_f)
  end

  def within_bounds(min_lat:, max_lat:, min_lng:, max_lng:)
    where(
      lat: (min_lat..max_lat),
      lng: (min_lng..max_lng)
    )
  end

  private

  def build_generator(latitude, longitude)
    Locator.from_degrees(latitude, longitude)
  end

  def query(generator, radius)
    ranges = generator.bounding_range(radius)
    where(lat: ranges[:latitude], lng: ranges[:longitude])
  end
end
