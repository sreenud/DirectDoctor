class DoctorFilterComponent < ViewComponent::Base
  attr_reader :filters
  def initialize(**filters)
    @filters = filters
  end

  def check_box_checked?(name, value)
    selected = make_array(filters[name])
    selected.include?(value)
  end

  private

  def make_array(value)
    return value.split(',') if value.class == String
    return value if value.class == Array

    value.to_a
  end
end
