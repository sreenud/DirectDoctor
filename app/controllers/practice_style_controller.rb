class PracticeStyleController < BaseController
  before_action :set_meta_data, only: [:index]

  def index
    @style_specialties = if params[:practice_style] == 'dpc'
      Speciality.dpc
    else
      Speciality.cm
    end

    @states = State.all
    @cities = Location.top.limit(60)
  end

  private

  def set_meta_data
    @allow_robots = true
  end
end
