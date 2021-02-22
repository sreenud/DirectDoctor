class SearchesController < BaseController
  include Pagy::Frontend
  # before_action :set_meta_data, only: [:index]
  before_action :load_gmap, only: [:index_two]
  before_action :set_location_string, only: [:index_two]

  def index
  end

  def index_two
    @pagy, @doctors = pagy(
      Doctor.includes(:speciality, :review_data).published.search(search_params,
current_location: current_location), items: 10
    )
    respond_to do |format|
      format.html
      format.json { render(json: json_results) } # for limiting the usage of map render calls
    end
  end

  def specialized_search
    @pagy, @doctors = pagy(
      Doctor.includes(:speciality, :review_data).published.search(converted_params,
current_location: current_location), items: 10
    )
    respond_to do |format|
      format.html { render(:index_two) }
      format.json { render(json: json_results) } # for limiting the usage of map render calls
    end
  end

  private

  def search_params
    @search_params ||= params.permit(
      :near,
      :place,
      :rating,
      :experience,
      :price,
      :holistic_medicine,
      :telehealth,
      :life_style_medicine,
      :speciality,
      :practice_type,
      :speciality_name
    )
  end

  def converted_params
    slug_params = fetch_city_speciality
    search_params.merge(slug_params)
  end

  def fetch_city_speciality
    @special_speciality = Speciality.select(:code).where(
      slug: params[:speciality_slug]
    ).first&.code

    {}.tap do |h|
      h[:place] = params[:place].titleize
      h[:speciality] = @special_speciality
    end
  end

  def set_meta_data
    @allow_robots = true
  end

  def json_results
    {
      results: render_component_to_string(DoctorComponent.with_collection(@doctors)),
      pins: @doctors.map { |d| "#{d.lat},#{d.lng},$#{d.min_price} - #{d.max_price},#{d.id}" },
      next: @pagy.next,
      prev: @pagy.prev,
      page: @pagy.page,
      total_records: @pagy.count,
      max_distance: @doctors.map(&:distance).max,
      pagination: @pagy.next || @pagy.prev ? pagy_nav(@pagy) : 'No results found',
      location_string: location_string,
    }
  end
end
