class JobsController < ApplicationController
  before_action :set_meta_data, only: [:show]

  def index
  end

  def show
  end

  def search
  end

  private

  def set_meta_data
    @allow_robots = false
  end
end
