class HomeController < BaseController
  before_action :set_meta_data, only: [:index]

  def index
    @survey = Survey.new
    @questions = Survey.questions
  end

  def static_page
    @cities = Location.top.limit(60)
  end

  private

  def set_meta_data
    @allow_robots = true
  end
end
