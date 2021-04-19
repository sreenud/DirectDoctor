class Doctor
  module DisplayContent
    extend ActiveSupport::Concern

    def display_practice_name
      if style == "dpc"
        "Direct Primary Care"
      elsif style == "concierge"
        "Concierge"
      else
        "Direct Primary Care/Concierge"
      end
    end

    def display_access
      if access.downcase == "yes"
        "24/7 365 Direct Access"
      elsif access.downcase == "no"
        "No"
      else
        "Not Available"
      end
    end

    def display_appointments
      if !appointments.present?
        "NA"
      elsif appointments.downcase == "not available"
        "Not Available"
      else
        appointments&.gsub(" appointments", "")&.gsub(",", ", ")
      end
    end

    def display_free_consultation_time
      if !free_consultation_time.present?
        "Not Available"
      else
        "#{free_consultation_time} min"
      end
    end

    def free_consultation_class
      if consultation.downcase == "yes"
        "text-green-500"
      elsif consultation.downcase == "no"
        "text-red-500"
      else
        "text-yellow-500"
      end
    end

    def display_free_consultation
      if consultation.downcase == "not available"
        "Free Consultation - Pending"
      else
        "Free Consultation"
      end
    end

    def holistic_lifestyle_class
      if is_holistic_medicine.downcase == "yes"
        "text-green-500"
      elsif is_holistic_medicine.downcase == "no"
        "text-red-500"
      else
        "text-yellow-500"
      end
    end

    def display_holistic_lifestyle
      if is_holistic_medicine.downcase == "not_available"
        "Holistic/Lifestyle Med - Pending"
      else
        "Holistic/Lifestyle Med"
      end
    end

    def telehealth_class
      if is_telehealth_service.downcase == "yes"
        "text-green-500"
      elsif is_telehealth_service.downcase == "no"
        "text-red-500"
      else
        "text-yellow-500"
      end
    end

    def display_telehealth
      if is_telehealth_service.downcase == "not_available"
        "Telehealth - Pending"
      else
        "Telehealth"
      end
    end

    def home_visit_class
      if is_home_visit.downcase == "yes"
        "text-green-500"
      elsif is_home_visit.downcase == "no"
        "text-red-500"
      else
        "text-yellow-500"
      end
    end

    def display_home_visit
      if is_home_visit.downcase == "not_available"
        "Home Visit - Pending"
      else
        "Home Visit"
      end
    end
  end
end
