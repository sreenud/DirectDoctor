module DoctorFormData
  extend ActiveSupport::Concern

  def new_doctor_object
    @doctor = Doctor.new(
      min_experience: 0,
      max_experience: 0,
      min_patients: 0,
      max_patients: 0,
      min_price: 0,
      max_price: 0,
    )
  end

  private

  def set_master_data
    @statuses = Doctor.statuses
    @doctor_degrees = DoctorDegree.latest
    @specialities = Speciality.latest
    @states = State.by_name

    @patients_in_panel = Doctor.patients_in_panels
    if current_user.has_role?("admin") || current_user.has_role?("data_entry")
      @patients_in_panel = { "0-0" => "Not available" }.merge!(@patients_in_panel)
    end

    @price_ranges = Doctor.price_ranges
    if current_user.has_role?("admin") || current_user.has_role?("data_entry")
      @price_ranges = { "0-0" => "Not available" }.merge!(@price_ranges)
    end

    @experiences = Doctor.experiences
    if current_user.has_role?("admin") || current_user.has_role?("data_entry")
      @experiences = { "0-0" => "Not available" }.merge!(@experiences)
    end
  end
end
