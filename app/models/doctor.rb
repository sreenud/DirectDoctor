class Doctor < ApplicationRecord
  extend DoctorSearch
  include ImageUploader::Attachment(:image)

  attr_accessor :cost, :experience, :patients_options, :price_options

  belongs_to :speciality

  scope :latest, -> { order(created_at: :desc) }

  validates :title, :gender, :name, :practice_name, :style, :primary_speciality,
    :language, :is_holistic_medicine, :is_telehealth_service, :is_home_visit,
    :aditional_services, :access, :appointments, :consultation, :about_clinic,
    :about_doctor, :address_line_1, :state, :city, :zipcode, :lat, :lng, presence: true

  validate :validate_holistic_option, :validate_telehealth_option, :validate_home_visit_option
  # ,:validate_patients_options, :validate_price_options

  before_save :set_language, :set_degree, :set_name, :set_additional_service, :set_appointments,
    :set_holistic_option, :set_telehealth_option, :set_home_visit_option, :set_free_consultation_time,
    :set_consultation

  after_create :set_fdd_id

  geocoded_by :address, latitude: :lat, longitude: :lng

  reverse_geocoded_by :lat, :lng

  enum status: {
    draft: "draft",
    review: "review",
    published: "published",
    archive: "archive",
  }

  enum practice: {
    dpc: "Direct Primary Care",
    concierge: "Concierge",
    both: "Both",
  }

  enum holistic_medicine: {
    "yes": "Yes",
    "no": "No",
    'not_available': 'Not available',
  }

  def self.experiences
    {
      "0-5" => "0 - 5 years",
      "6-10" => "6 - 10 years",
      "11-20" => "11 - 20 years",
      "20" => ">20 years",
    }
  end

  def self.price_ranges
    {
      "25-100" => "$25 - $100",
      "101-250" => "$101 - $250",
      "251-500" => "$251 - $500",
      "500" => ">$500",
    }
  end

  def self.patients_in_panels
    {
      "0-50" => "<50 patients",
      "51-200" => "51 - 200 patients",
      "201-500" => "201 - 500 patients",
      "501-1000" => "501 - 1000 patients",
      "1000" => ">1000 patients",
    }
  end

  def self.default_experience
    Doctor.experiences&.first&.first&.split("-")
  end

  def self.default_patient
    Doctor.patients_in_panels&.first&.first&.split("-")
  end

  def self.default_price
    Doctor.price_ranges&.first&.first&.split("-")
  end

  def address
    [address_line_1, city, state, zipcode].compact.join(', ')
  end

  def price
    "$#{min_price} - #{max_price}"
  end

  def formated_phone_number
    phone.gsub(/[^0-9]/, '')
  end

  def display_practice_name
    if style == 'dpc'
      "Direct Primary Care"
    elsif style == 'concierge'
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
      appointments&.gsub(' appointments', '')&.gsub(',', ', ')
    end
  end

  def display_free_consultation_time
    if !free_consultation_time.present?
      "NA"
    else
      "#{free_consultation_time} min"
    end
  end

  def free_consultation_class
    if consultation.downcase == 'yes'
      "text-green-500"
    elsif consultation.downcase == 'no'
      "text-red-500"
    else
      "text-yellow-500"
    end
  end

  def display_free_consultation
    if consultation.downcase == 'not available'
      "Free Consultation - Pending"
    else
      "Free Consultation"
    end
  end

  def holistic_lifestyle_class
    if is_holistic_medicine.downcase == 'yes'
      "text-green-500"
    elsif is_holistic_medicine.downcase == 'no'
      "text-red-500"
    else
      "text-yellow-500"
    end
  end

  def display_holistic_lifestyle
    if is_holistic_medicine.downcase == 'not_available'
      "Holistic/Lifestyle Med - Pending"
    else
      "Holistic/Lifestyle Med"
    end
  end

  def telehealth_class
    if is_telehealth_service.downcase == 'yes'
      "text-green-500"
    elsif is_telehealth_service.downcase == 'no'
      "text-red-500"
    else
      "text-yellow-500"
    end
  end

  def display_telehealth
    if is_telehealth_service.downcase == 'not_available'
      "Telehealth - Pending"
    else
      "Telehealth"
    end
  end

  def home_visit_class
    if is_home_visit.downcase == 'yes'
      "text-green-500"
    elsif is_home_visit.downcase == 'no'
      "text-red-500"
    else
      "text-yellow-500"
    end
  end

  def display_home_visit
    if is_home_visit.downcase == 'not_available'
      "Home Visit - Pending"
    else
      "Home Visit"
    end
  end

  private

  def set_fdd_id
    self.fdd_id = "#{state_code}-#{primary_speciality}-#{zipcode}-#{format('%05d', id)}"
    save
  end

  def state_code
    State.find_by_name(state)&.code
  end

  def set_language
    self.language = hash_to_string(JSON.parse(language)) if validate_json(language)
  end

  def set_degree
    self.title = hash_to_string(JSON.parse(title)) if validate_json(title)
  end

  def set_name
    self.name = hash_to_string(JSON.parse(name)) if validate_json(name)
  end

  def set_additional_service
    self.aditional_services = hash_to_string(JSON.parse(aditional_services)) if validate_json(aditional_services)
  end

  def set_appointments
    self.appointments = hash_to_string(JSON.parse(appointments)) if validate_json(appointments)
  end

  def set_holistic_option
    self.holistic_option = hash_to_string(JSON.parse(holistic_option)) if validate_json(holistic_option)
  end

  def set_telehealth_option
    self.telehealth_option = hash_to_string(JSON.parse(telehealth_option)) if validate_json(telehealth_option)
  end

  def set_home_visit_option
    self.home_visit_option = hash_to_string(JSON.parse(home_visit_option)) if validate_json(home_visit_option)
  end

  def set_free_consultation_time
    if validate_json(free_consultation_time)
      self.free_consultation_time = hash_to_string(JSON.parse(free_consultation_time))
    end
  end

  def set_consultation
    self.consultation = hash_to_string(JSON.parse(consultation)) if validate_json(consultation)
  end

  def hash_to_string(hashes)
    hashes.map { |hash| [hash['value']] }&.join(",")
  end

  def validate_holistic_option
    if is_holistic_medicine == 'yes' && holistic_option.blank?
      errors.add(:holistic_option, 'should be present')
    end
  end

  def validate_telehealth_option
    if is_telehealth_service == 'yes' && telehealth_option.blank?
      errors.add(:telehealth_option, 'should be present')
    end
  end

  def validate_home_visit_option
    if is_home_visit == 'yes' && home_visit_option.blank?
      errors.add(:home_visit_option, 'should be present')
    end
  end

  def validate_patients_options
    if patients_options == 'other' && prices.blank?
      errors.add(:patients_in_panel, 'should be present')
    end
  end

  def validate_price_options
    if price_options == 'other' && patients_in_panel.blank?
      errors.add(:prices, 'should be present')
    end
  end

  def validate_json(json_data)
    JSON.parse(json_data)
  rescue JSON::ParserError => e
    false
  end
end
