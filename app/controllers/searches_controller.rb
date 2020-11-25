class SearchesController < ApplicationController
  before_action :set_meta_data, only: [:index]
  before_action :load_gmap, only: [:index_two]

  def index
  end

  def index_two
    @pagy, @doctors = pagy(
      Doctor.search(search_params, current_location: current_location)
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
      :rating,
      :experience,
      :price,
      :holistic_medicine,
      :telehealth,
      :life_style_medicine
    )
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
      max_distance: @doctors.map(&:distance).max,
    }
  end
end
