class LocationConstraint
  def matches?(request)
    Location.where('name ILIKE ?', "%#{request.path_parameters[:location]}").present?
  end
end
