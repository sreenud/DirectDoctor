class IpCheckController < ApplicationController

  def index
    @geo_result = Geocoder.search(request.remote_ip).first

    @coordinates = @geo_result.present? && @geo_result.data["loc"] ? @geo_result.data["loc"] : "40.73061,-73.935242"

    @coords = coordinates.split(",").map(&:to_f)
    @result = Geocoder.search(@coords).first
    @location_string = (@result.data["address"] || {})["city"]
  end

end
