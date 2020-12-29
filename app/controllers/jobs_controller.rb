class JobsController < ApplicationController
  before_action :set_meta_data, only: [:show]
  before_action :load_gmap, only: [:search]
  before_action :set_location_string, only: [:search]

  def index
  end

  def show
  end

  def search
    @pagy, @doctors = pagy(
      Doctor.joins(:jobs, :speciality)
      .select("doctors.name AS doctor_name, doctors.city, doctors.state, doctors.style,
      doctors.fmdd_score, doctors.image_data, jobs.specialities, jobs.degree, jobs.hours, jobs.salary,
      jobs.sign_on_bonus, jobs.loan_assistance, jobs.id AS job_id")
      .job_search(search_params, current_location: current_location)
    )
    respond_to do |format|
      format.html
      format.json { render json: json_results } # for limiting the usage of map render calls
    end
  end

  private

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
      results: render_component_to_string(JobComponent.with_collection(@doctors)),
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
