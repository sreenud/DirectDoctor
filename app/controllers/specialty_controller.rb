class SpecialtyController < BaseController
  before_action :set_meta_data, only: [:index]

  def index
    @specialty = Speciality.find_by_code(params[:specialty]&.upcase)
    @states = State.all
    @cities = Location.top.limit(60)
    @style = params[:practice_style]
  end

  private

  def set_meta_data
    @allow_robots = true
  end
end
