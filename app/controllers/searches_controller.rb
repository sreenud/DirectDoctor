class SearchesController < ApplicationController
  before_action :set_meta_data, only: [:index]

  def index
  end

  private

  def set_meta_data
    @allow_robots = true
  end
end
