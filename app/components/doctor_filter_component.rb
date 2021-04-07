class DoctorFilterComponent < ViewComponent::Base
  attr_reader :filters
  def initialize(special_near:, special_speciality:, **filters)
    @filters = filters
    @special_near = special_near
    @special_speciality = special_speciality
  end

  def check_box_checked?(name, value)
    selected = make_array(filters[name])
    selected.include?(value)
  end

  def speciality_list
    @speciality_list ||= [["All", "all"]] + Speciality.all.pluck(:name, :code)
  end

  private

  def make_array(value)
    return value.split(",") if value.class == String
    return value if value.class == Array

    value.to_a
  end
end
