# frozen_string_literal: true

# a module for generating results for doctor search through parameters
module DoctorSearch
  def search(params)
    @params = params
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

  def apply_location_filter
    return @default_scope unless @params[:near].present? || @params[:place].present?
    @default_scope.near(
      to_coordinates(@params[:near]) || @params[:place],
      10,
      units: :km
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
    near.split(',').map(&:to_f)
  end
end
