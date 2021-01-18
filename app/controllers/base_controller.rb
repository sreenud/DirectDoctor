class BaseController < ApplicationController
  include Pagy::Backend

  DEFUALT_LOCATION = '40.73061,-73.935242'

  attr_reader :current_location, :location_string

  before_action :menu_details, only: %i[index show], unless: proc { request.xhr? }
  before_action :set_approximate_location, :validate_role

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

  def set_location_string
    return if location_string.present?
    return @location_string = params[:place] if params[:place].present?
    coords = (params[:near].presence || DEFUALT_LOCATION).split(',').map(&:to_f)
    result = Geocoder.search(coords).first
    @location_string = (result.data['address'] || {})['city']
  end

  def validate_role
    if current_user.present? && current_user.has_role?('guest')
      redirect_to(onboarding_step1_url) && return
    end
  end

  private

  def menu_details
    menu_blog_categories
  end

  def menu_blog_categories
    @menu_categories = Category.latest.limit(5)
  end
end
