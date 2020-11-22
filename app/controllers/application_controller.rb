class ApplicationController < ActionController::Base
  include Pagy::Backend

  DEFUALT_LOCATION = '40.73061,-73.935242'

  attr_reader :current_location

  before_action :menu_details, only: %i[index show], unless: proc { request.xhr? }
  before_action :set_approximate_location

  def load_gmap
    @load_gmaps = true
  end

  def set_approximate_location
    @current_location = session[:current_location]
    return if @current_location.present?

    geo_result = Geocoder.search(request.remote_ip).first
    coordinates = geo_result.data['loc'] || DEFUALT_LOCATION
    session[:current_location] = coordinates
    @current_location = coordinates
  end

  def to_coordinates(lat_lng)
    lat_lng.split(',').map(&:to_f)
  end

  private

  def menu_details
    menu_blog_categories
  end

  def menu_blog_categories
    @menu_categories = Category.latest.limit(5)
  end
end
