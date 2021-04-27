class LocationConstraint
  def matches?(request)
    location_name = request.path_parameters[:location]&.titleize
    Location.where("name ILIKE ?", "%#{location_name}").present?
  end
end
