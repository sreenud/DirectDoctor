class HomeController < ApplicationController
  def index
    @survey = Survey.new
    @questions = Survey.questions
  end
end
