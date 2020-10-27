module Admin
  module DoctorHelper
    def experience_string(doctor)
      "#{doctor.min_experience}-#{doctor.max_experience}"
    end

    def experience_options(experiences)
      experiences.map do |key, value|
        [
          value,
          key,
          { data: { 'min-experience': key&.split('-')&.first, 'max-experience': key&.split('-')&.last } },
        ]
      end
    end

    def patient_string(doctor)
      "#{doctor.min_patients}-#{doctor.max_patients}"
    end

    def patient_options(patiants)
      patiants.map do |key, value|
        [
          value,
          key,
          { data: { 'min-patients': key&.split('-')&.first, 'max-patients': key&.split('-')&.last } },
        ]
      end
    end

    def price_string(doctor)
      "#{doctor.min_price}-#{doctor.max_price}"
    end

    def price_options(patiants)
      patiants.map do |key, value|
        [
          value,
          key,
          { data: { 'min-price': key&.split('-')&.first, 'max-price': key&.split('-')&.last } },
        ]
      end
    end
  end
end
