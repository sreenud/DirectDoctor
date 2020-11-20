class SearchesController < ApplicationController
  before_action :set_meta_data, only: [:index]
  before_action :load_gmap, only: [:index_two]

  def index
  end

  def index_two
  end

  private

  def set_meta_data
    @allow_robots = true
  end
end
