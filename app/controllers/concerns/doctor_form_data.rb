module DoctorFormData
  extend ActiveSupport::Concern

  def new_doctor_object
    @doctor = Doctor.new(
      min_experience: Doctor.default_experience&.first,
      max_experience: Doctor.default_experience&.last,
      min_patients: Doctor.default_patient&.first,
      max_patients: Doctor.default_patient&.last,
      min_price: Doctor.default_price&.first,
      max_price: Doctor.default_price&.last,
    )
  end

  private

  def set_master_data
    @statuses = Doctor.statuses
    @doctor_degrees = DoctorDegree.latest
    @specialities = Speciality.latest
    @states = State.by_name

    @patients_in_panel = Doctor.patients_in_panels
    if current_user.has_role?(:admin) || current_user.has_role?(:data_entry)
      @patients_in_panel = @patients_in_panel.merge!({ '0-0' => 'Not available' })
    end

    @price_ranges = Doctor.price_ranges
    if current_user.has_role?(:admin) || current_user.has_role?(:data_entry)
      @price_ranges = @price_ranges.merge!({ '0-0' => 'Not available' })
    end

    @experiences = Doctor.experiences
    if current_user.has_role?(:admin) || current_user.has_role?(:data_entry)
      @experiences = @experiences.merge!({ '0-0' => 'Not available' })
    end
  end
end
