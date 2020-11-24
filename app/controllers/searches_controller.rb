class SearchesController < ApplicationController
  before_action :set_meta_data, only: [:index]
  before_action :load_gmap, only: [:index_two]

  def index
  end

  def index_two
    @pagy, @doctors = pagy(
      Doctor.search(search_params, current_location: current_location)
    )
  end

  private

  def search_params
    @search_params ||= params.permit(:near, :place, :ratings, :experience, :price)
  end

  def set_meta_data
    @allow_robots = true
  end
end
