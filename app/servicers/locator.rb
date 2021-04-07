# frozen_string_literal: true

# a class for calculating the coordinates range and filtering the data from queries
class Locator
  include Math
  # constants
  MAX_LAT = 90 * Math::PI / 180
  MIN_LAT = -90 * Math::PI / 180
  MAX_LON = 180 * Math::PI / 180
  MIN_LON = -180 * Math::PI / 180
  EARTH_RADIUS = 6378.1

  attr_accessor :rad_lat, :rad_lon, :lat, :lon

  def self.from_degrees(latitude, longitude)
    rad_lat = to_radian(latitude)
    rad_lon = to_radian(longitude)
    new(latitude, longitude, rad_lat, rad_lon)
  end

  def self.from_radians(latitude, longitude)
    deg_lat = to_degree(latitude)
    deg_lon = to_degree(longitude)
    new(deg_lat, deg_lon, latitude, longitude)
  end

  def self.to_radian(value)
    value.to_f * Math::PI / 180
  end

  def self.to_degree(value)
    value.to_f * 180 / Math::PI
  end

  def initialize(lat, lon, rad_lat, rad_lon)
    @lat = lat.to_f
    @lon = lon.to_f
    @rad_lat = rad_lat.to_f
    @rad_lon = rad_lon.to_f
    bound_check
  end

  def bounding_points(radius = 1)
    radial_dist = radius / EARTH_RADIUS
    min_lat = rad_lat - radial_dist
    max_lat = rad_lat + radial_dist
    min_lon, max_lon = calculate_lon_range(min_lat, max_lat, radial_dist)
    min_lat, max_lat = adjust_lat_bounds(min_lat, max_lat)
    [
      self.class.from_radians(min_lat, min_lon),
      self.class.from_radians(max_lat, max_lon),
    ]
  end

  def to_coordinates
    [lat, lon]
  end

  def bounding_range(radius = 1)
    sw, ne = bounding_points(radius)
    {
      latitude: (sw.lat..ne.lat),
      longitude: (sw.lon..ne.lon),
    }
  end

  private

  def bound_check
    if rad_lat < MIN_LAT || rad_lat > MAX_LAT || rad_lon < MIN_LON || rad_lon > MAX_LON
      raise(ArgumentError, "Invalid coordinates are passed")
    end
  end

  def calculate_lon_range(min_lat, max_lat, radial_dist)
    if min_lat > MAX_LAT && max_lat < MAX_LAT
      delta_lon = asin(sin(radial_dist) / cos(rad_lat))
      min_lon = rad_lon - delta_lon
      min_lon += 2 * Math::PI if min_lon < MIN_LON
      max_lon = rad_lon + delta_lon
      max_lon -= 2 * Math::PI if min_lon > MAX_LON
      [min_lon, max_lon]
    else
      [MIN_LON, MAX_LON]
    end
  end

  def adjust_lat_bounds(min_lat, max_lat)
    return [min_lat, max_lat] if min_lat > MIN_LAT && max_lat < MAX_LAT
    [
      [min_lat, MIN_LAT].max,
      [max_lat, MAX_LAT].min,
    ]
  end
end
