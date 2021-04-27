class DoctorStyleConstraint
  def matches?(request)
    ["dpc", "cm"].include?(request.path_parameters[:style])
  end
end
