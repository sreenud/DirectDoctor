class SearchesController < BaseController
  include Pagy::Frontend
  include SchemaHelper
  include BreadCrumbHelper
  include ApplicationHelper
  before_action :set_meta_data, only: [:index, :index_two, :specialized_search]
  before_action :load_gmap, only: [:index_two]
  before_action :set_location_string, only: [:index_two]

  def index
  end

  def index_two
    state = State.valid_state(params[:place])
    @state_cities = state.locations.top.limit(60) if state
    current_location = @current_location_coords
    @pagy, @doctors = pagy(
      Doctor.includes(:speciality, :review_data).published.search(search_params,
        current_location: current_location), items: 10
    )

    @faqs = Faq.published
    @schema = srp_page_schema(@doctors)
    @srp_bread_crumbs = search_page_bread_crumb(params)

    respond_to do |format|
      format.html
      format.json { render(json: json_results) } # for limiting the usage of map render calls
    end
  end

  def specialized_search
    unless params[:city].present?
      state = State.state_with_code(params[:state])
      @state_cities = state.locations.top.limit(60) if state
    end
    @pagy, @doctors = pagy(
      Doctor.includes(:speciality, :review_data).published.search(converted_params,
        current_location: current_location), items: 10
    )

    @faqs = Faq.published
    @schema = srp_page_schema(@doctors)
    @local_business_schema = local_business_schema(params)
    @srp_bread_crumbs = srp_page_bread_crumb(params)

    respond_to do |format|
      format.html { render(:index_two) }
      format.json { render(json: json_results) } # for limiting the usage of map render calls
    end
  end

  def global_search
    @doctors  = Doctor.ransack(name_cont: params[:q]).result(distinct: true)
      .where(status: "published").limit(5)
    @clinics  = Doctor.ransack(practice_name_cont: params[:q]).result.select(:practice_name)
      .where(status: "published").group("doctors.practice_name").limit(5)
    @spcialities = Speciality.ransack(name_cont: params[:q]).result(distinct: true).limit(5)

    render(layout: false)
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
      :speciality_name,
      :doctor_name,
      :clinic_name,
      :specialty,
      :state,
      :practice_style
    )
  end

  def converted_params
    slug_params = fetch_city_speciality
    search_params.merge(slug_params)
  end

  def fetch_city_speciality
    @special_speciality = if params[:specialty] != "doctors"
      params[:speciality] = params[:specialty]&.upcase
    else
      ""
    end

    if params[:state].present?
      state = State.where(code: params[:state].upcase)&.first
      place_name = state&.name
    end
    if params[:city].present? &&  params[:city] != "doctor_default"
      city = Location.where(name: params[:city].titleize)&.first
      # city = city&.name
      place_name = city&.name
    end

    {}.tap do |h|
      h[:style] = params[:style]
      # h[:city] = city
      h[:place] = place_name
      h[:speciality] = @special_speciality
      h[:doctor_name] = params[:doctor_name]
      h[:clinic_name] = params[:clinic_name]
    end
  end

  def set_meta_data
    @allow_robots = false
    @no_directory = true

    place_holder = "#{params["state"].upcase}, USA" if params["state"].present?
    @meta_title ||= "Find the nearest Concierge Doctors and Direct Primary Care Physicians in #{place_holder}"
    @meta_description ||= "Find nearest Direct Primary Care Physicians and Concierge Doctors in
      #{place_holder} on Findmydirectdoctor.com. Search by specialties, localities, symptoms, conditions etc."
  end

  def json_results
    {
      results: render_component_to_string(DoctorComponent.with_collection(@doctors, current_user: current_user)),
      pins: @doctors.map { |d| "#{d.lat},#{d.lng},$#{d.min_price} - #{d.max_price},#{d.id}" },
      next: @pagy.next,
      prev: @pagy.prev,
      page: @pagy.page,
      total_records: @pagy.count,
      max_distance: @doctors.map(&:distance).max,
      pagination: @pagy.next || @pagy.prev ? pagy_nav(@pagy) : "No results found",
      location_string: location_string,
    }
  end
end
