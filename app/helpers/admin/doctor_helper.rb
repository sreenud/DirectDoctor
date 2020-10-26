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
  end
end
