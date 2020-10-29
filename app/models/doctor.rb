class Doctor < ApplicationRecord
  include ImageUploader::Attachment(:image)

  attr_accessor :cost, :experience

  scope :latest, -> { order(created_at: :desc) }

  validates :title, :gender, :name, :practice_name, :style, :primary_speciality,
    :language, :is_holistic_medicine, :is_telehealth_service, :is_home_visit,
    :aditional_services, :access, :appointments, :consultation, :about_clinic,
    :about_doctor, :address_line_1, :state, :city, :zipcode, :lat, :lng, presence: true

  validate :validate_holistic_option, :validate_telehealth_option, :validate_home_visit_option

  before_save :set_language, :set_degree, :set_additional_service, :set_appointments,
    :set_holistic_option, :set_telehealth_option, :set_home_visit_option, :set_free_consultation_time,
    :set_consultation

  after_create :set_fdd_id

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

  enum patients_in_panel: {
    "0-50": "<50 patients",
    "51-200": "51 - 200 patients",
    "201-500": "201 - 500 patients",
    "501-1000": "501 - 1000 patients",
    "1000": ">1000 patients",
  }

  enum experience: {
    "0-5": "0 - 5 years",
    "6-10": "6 - 10 years",
    "11-20": "11 - 20 years",
    "20": ">20 years",
  }

  enum holistic_medicine: {
    "yes": "Yes",
    "no": "No",
  }

  enum price_range: {
    "25-100": "$25 - $100",
    "101-250": "$101 - $250",
    "251-500": "$251 - $500",
    "500": ">$500",
  }

  def self.default_experience
    experiences&.first&.first&.split("-")
  end

  def self.default_patient
    patients_in_panels&.first&.first&.split("-")
  end

  def self.default_price
    price_ranges&.first&.first&.split("-")
  end

  private

  def set_fdd_id
    self.fdd_id = "#{state}-#{primary_speciality}-#{zipcode}-#{format('%04d', id)}"
    save
  end

  def set_language
    self.language = hash_to_string(JSON.parse(language)) if validate_json(language)
  end

  def set_degree
    self.title = hash_to_string(JSON.parse(title)) if validate_json(title)
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

  def validate_json(json_data)
    JSON.parse(json_data)
  rescue JSON::ParserError => e
    false
  end
end
