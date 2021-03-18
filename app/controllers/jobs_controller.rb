class JobsController < BaseController
  before_action :set_meta_data, only: [:show]
  before_action :load_gmap, only: [:search]
  before_action :set_location_string, only: [:search]
  before_action :set_job, only: [:show]

  def index
    @specialities = Speciality.all
    @cities = Location.all.limit(100)
    @states = State.all
  end

  def show
    @doctor_rating = ReviewData.find_by_doctor_id(@job&.doctor&.id)
  end

  def search
    @pagy, @doctors = pagy(
      Doctor.joins(:jobs, :speciality)
      .select("doctors.name AS doctor_name, doctors.city, doctors.state, doctors.style,
      doctors.fmdd_score, doctors.image_data, jobs.specialities, jobs.degree, jobs.hours, jobs.salary,
      jobs.sign_on_bonus, jobs.loan_assistance, jobs.id AS job_id, specialities.name AS speciality_name,
      jobs.created_at AS job_posted_on, doctors.lat, doctors.lng")
      .job_search(search_params, current_location: current_location)
    )
    doctor_ids = @doctors.map(&:id)
    @reviews = ReviewData.where(doctor_id: doctor_ids)
    @reviews_data = @reviews.group_by(&:doctor_id)

    respond_to do |format|
      format.html
      format.json { render(json: json_results) } # for limiting the usage of map render calls
    end
  end

  def post_job
  end

  private

  def set_job
    @job = Job.find_by_id(params[:id])
  end

  def search_params
    @search_params ||= params.permit(
      :near,
      :place,
      :degree,
      :speciality_name,
      :practice_type,
      :location,
      :hours,
      :visa_sponsorship
    )
  end

  def json_results
    {
      results: render_component_to_string(JobComponent.with_collection(@doctors, reviews_data: @reviews_data)),
      pins: @doctors.map { |doctor| "#{doctor.lat},#{doctor.lng}" },
      next: @pagy.next,
      prev: @pagy.prev,
      page: @pagy.page,
      max_distance: @doctors.map(&:distance).max,
      pagination: @pagy.next || @pagy.prev ? pagy_nav(@pagy) : 'No results found',
      location_string: location_string,
    }
  end

  def set_meta_data
    @allow_robots = false
  end
end
