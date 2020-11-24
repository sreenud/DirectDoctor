class DoctorFilterComponent < ViewComponent::Base
  attr_reader :filters
  def initialize(**filters)
    @filters = filters
  end
end
