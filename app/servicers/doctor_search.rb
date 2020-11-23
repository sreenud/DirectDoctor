# frozen_string_literal: true

# a module for generating results for doctor search through parameters
module DoctorSearch
  SEARCH_RADIUS = 100
  SEARCH_UNITS = :km
  DEFAULT_LOCATION = ApplicationController::DEFUALT_LOCATION
  def search(params, current_location: DEFAULT_LOCATION)
    @params = params
    @current_location = to_coordinates(current_location)
    @default_scope = Doctor
    apply_filters
  end

  private

  def apply_filters
    apply_ratings_filter
    apply_practice_filter
    apply_experience_filter
    apply_fee_filter
    apply_location_filter
  end

  # tries to find a doctor in 50 km radius first and then fallbacks to 10000km radius
  # results are ordered in the order of distance to the selected location
  def apply_location_filter
    return @default_scope unless @params[:near].present? || @params[:place].present? || @current_location.present?
    near = @default_scope.near(
      to_coordinates(@params[:near]) || @params[:place] || @current_location,
      SEARCH_RADIUS,
      units: SEARCH_UNITS
    )
    return near if near.present?

    @default_scope.near(
      to_coordinates(@params[:near] || '') || @params[:place] || @current_location,
      10000, # maximum can be around 41000
      units: SEARCH_UNITS
    )
  end

  def apply_ratings_filter
    return @default_scope unless @params[:ratings].present?

    # more_than = @params[:ratings].match(/\d/).to_i
    # more_than = more_than <= 5 ? more_than : 5
    # TODO: insert a logic once ratings is added to platform
    @default_scope
  end

  def apply_practice_filter
    @default_scope
  end

  def apply_experience_filter
    @default_scope
  end

  def apply_fee_filter
    @default_scope
  end

  def to_coordinates(near)
    return unless near.present?

    near.split(',').map(&:to_f)
  end
end
