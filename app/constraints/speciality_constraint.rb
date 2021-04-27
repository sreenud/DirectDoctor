class SpecialityConstraint
  def matches?(request)
    specialty_name = request.path_parameters[:speciality_slug]&.titleize
    Speciality.where('name ILIKE ?', "%#{specialty_name}").present?
  end
end
