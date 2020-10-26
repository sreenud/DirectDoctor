class HomeController < ApplicationController
  before_action :set_meta_data, only: [:index]

  def index
    @survey = Survey.new
    @questions = Survey.questions
  end

  private

  def set_meta_data
    @allow_robots = true
  end
end
