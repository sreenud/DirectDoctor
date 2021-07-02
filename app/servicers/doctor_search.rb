# frozen_string_literal: true

# a module for generating results for doctor search through parameters
module DoctorSearch
  SEARCH_RADIUS = 1500
  SEARCH_UNITS = :km
  DEFAULT_LOCATION = BaseController::DEFUALT_LOCATION
  def search(params, current_location: DEFAULT_LOCATION)
    @params = params
    @current_location = to_coordinates(current_location)
    @default_scope = Doctor
    apply_filters
  end

  private

  def apply_filters
    convert_speciality_name_to_speciality
    apply_doctor_filter
    apply_clinic_filter
    apply_speciality_filter
    apply_ratings_filter
    apply_practice_filter
    apply_experience_filter
    apply_fee_filter
    apply_other_filters
    apply_city_filter
    apply_style_filter
    apply_location_filter
  end

  # tries to find a doctor in 50 km radius first and then fallbacks to 10000km radius
  # results are ordered in the order of distance to the selected location
  def apply_location_filter
    return @default_scope if @params[:doctor_name].present?
    return @default_scope unless @params[:near].present? || @params[:place].present? || @current_location.present?
    near = @default_scope.near(
      to_coordinates(@params[:near]) || @params[:place] || @current_location,
      SEARCH_RADIUS,
      units: SEARCH_UNITS
    )
    return near if near.present?

    @default_scope.near(
      to_coordinates(@params[:near] || "") || @params[:place] || @current_location,
      10000, # maximum can be around 41000
      units: SEARCH_UNITS
    )
  end

  def apply_style_filter
    return @default_scope unless @params[:style].present?

    style = if @params[:style] == "dpc"
      "dpc"
    else
      "concierge"
    end
    @default_scope = @default_scope.where(style: style)
  end

  def apply_city_filter
    return @default_scope unless @params[:city].present?

    @default_scope = @default_scope.where(city: @params[:city])
  end

  def convert_speciality_name_to_speciality
    return if @params[:speciality].present? || !@params[:speciality_name].present?

    @params[:speciality] = Speciality.where("name ilike '%#{@params[:speciality_name].downcase}%'").pluck(:code)
  end

  def apply_ratings_filter
    return @default_scope unless @params[:rating].present?

    more_than = @params[:rating].match(/\d/).to_a[0].to_i
    more_than = more_than <= 5 ? more_than..5 : 5
    @default_scope = @default_scope.where(avg_rating: more_than)
  end

  def apply_practice_filter
    return @default_scope unless @params[:practice_type].present?
    return @default_scope if @params[:practice_type] == "both"

    @default_scope = @default_scope.where(style: @params[:practice_type])
  end

  def apply_experience_filter
    return @default_scope unless @params[:experience].present?

    ranges = build_range(@params[:experience])
    @default_scope = @default_scope.where(max_experience: ranges, min_experience: ranges)
  end

  def apply_fee_filter
    return @default_scope unless @params[:price].present?

    ranges = build_range(@params[:price])
    @default_scope = @default_scope.where(min_price: ranges, max_price: ranges)
  end

  def apply_speciality_filter
    return @default_scope unless @params[:speciality].present?
    return @default_scope if @params[:speciality] == "all"

    @default_scope = @default_scope.where(primary_speciality: @params[:speciality])
  end

  def apply_doctor_filter
    return @default_scope unless @params[:doctor_name].present?

    @default_scope = @default_scope.where("name ilike '%#{@params[:doctor_name].downcase}%'")
  end

  def apply_clinic_filter
    return @default_scope unless @params[:clinic_name].present?

    @default_scope = @default_scope.where("practice_name ilike '%#{@params[:clinic_name].downcase}%'")
  end

  def apply_other_filters
    @default_scope = @default_scope.where(is_holistic_medicine: "yes") if @params[:holistic_medicine].present?
    @default_scope = @default_scope.where(is_telehealth_service: "yes") if @params[:holistic_medicine].present?
  end

  def to_coordinates(near)
    return unless near.present?

    near.split(",").map(&:to_f)
  end

  def build_range(value)
    array_value = value.split(",").map { |a| a.split("_") }
    array_value = array_value.map do |a|
      mx = a[1].to_i
      a[0] == "gt" ? (mx..) : (a[0].to_i..mx)
    end
    array_value
  end
end
