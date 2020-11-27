# frozen_string_literal: true

# a class for calculating the coordinates range and filtering the data from queries
class RadialCoordinates
  include Math
  EARTH_MEAN_RADIUS = 6371
  PI = Math::PI

  attr_accessor :latitude, :longitude, :radius

  # expects radius in KM
  def initialize(latitude, longitude, radius)
    @latitude = latitude
    @longitude = longitude
    @radius = radius
  end

  def range
    {
      max_latitude: latitude + radial_degree,
      min_latitude: latitude - radial_degree,
      min_longitude: longitude - radial_degree / longitude_differential,
      max_longitude: longitude + radial_degree / longitude_differential,
    }
  end

  def filter_records(points)
    points.select { |point| within?(point) }
  end

  private

  def radial_degree
    (radius.to_f / EARTH_MEAN_RADIUS) * (180 / PI)
  end

  def longitude_differential
    cos(latitude * (PI / 180))
  end

  def point_bound(point)
    acos(
      point_bound_sine(point) + point_bound_cosine(point)
    ) * EARTH_MEAN_RADIUS
  end

  def point_bound_sine(point)
    sin(
      point.lat * PI / 180
    ) * sin(
      latitude * PI / 180
    )
  end

  def point_bound_cosine(point)
    cos(
      point.lat * PI / 180
    ) * cos(
      latitude * PI / 180
    ) * cos(
      (point.lng * PI / 180) - (longitude * PI / 180)
    )
  end

  def within?(point)
    point_bound(point) < radius
  end
end
