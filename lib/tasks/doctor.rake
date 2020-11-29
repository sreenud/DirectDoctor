namespace :doctor do
  desc "Import Doctor"
  task import: :environment do
    file_name = "#{ENV['state_code']}.xlsx"
    state_name = State.find_by_code(ENV['state_code'])&.name
    spreadsheet = Roo::Excelx.new("#{Rails.root}/public/system/doctor_import/#{file_name}")
    header = spreadsheet.row(1)
    # header = header.map { |h| h.parameterize.gsub('-', '_') }
    records = []
    (2..spreadsheet.last_row).each_with_index do |i, _j|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      records << {
        'title' => doctor_title(row['Doctor Name']),
        'name' => doctor_name(row['Doctor Name']),
        'gender' => row["Gender"],
        'practice_name' => practice_name_data(row["Practice/Clinic Name"]),
        'style' => row['Style']&.downcase,
        'primary_speciality' => row["Speciality"],
        'address_line_1' => address_line_1(row['Address Line 1']),
        'city' => city_data(row['City']),
        'zipcode' => row['Zip Code'],
        'website_url' => strip_html_tags(row['Website URL']),
        'phone' => primary_phone(row['Phone']),
        'alternate_phones' => alternate_phones(row['Phone']),
        'fax' => row['Fax'],
        'email' => primary_email(row['Email']),
        'alternate_emails' => alternate_emails(row['Email']),
        'contact_us_url' => row['Contact method OR Contact Us URL'],
        'social_profiles' => to_jsonb(strip_html_tags(row['Social Media Profiles'])),
        'active_licenses' => active_licenses(row['DocInfo - Active Licenses']),
        'disciplinary_action_taken' => disciplinary_action_taken(row['DocInfo - Actions (Disciplinary)']),
        'about_clinic' => about_clinic(row['About the Clinic']),
        'about_doctor' => about_doctor(row['About the Doctor']),
        'prices' => strip_html_tags(row['Pricing (Monthly/Annual)']),
        'other_specialities' => other_specialities(row['Tags']),
        'aditional_services' => process_aditional_services(row),
        'old_fdd_id' => row['FDD-ID'],
        'state' => state_name,
        'is_holistic_medicine' => is_holistic_medicine_data(row["Holistic/Lifestyle Medicine"]),
        'holistic_option' => holistic_option_data(row["If you answered 'yes' to the previous question (Holistic/Lifestyle Medicine), please select one of the options below."]),
        'is_telehealth_service' => is_telehealth_service_data(row["Telehealth Services"]),
        'telehealth_option' => telehealth_option_data(row["If you answered 'yes' to the previous question (Telehealth Services), please select one of the options below."]),
        'is_home_visit' => is_home_visit_data(row["Home Visits"]),
        'home_visit_option' => home_visit_option_data(row["If you answered 'yes' to the previous question (Home Visits), please select one of the options below."]),
        'access' => access_data(row["24/7 Direct Phone Access to Doctor"]),
        'appointments' => appointments_data(row["Ability to See Patients"]),
        'consultation' => consultation_data(row["Free Initial Consultation"]),
        'free_consultation_time' => free_consultation_time_data(row["If you do offer a free initial consultation, how much time?"]),
        'lat' => 0,
        'lng' => 0,
        'min_experience' => min_experience_data(row["Doctor's Experience - Years in Practice"]),
        'max_experience' => max_experience_data(row["Doctor's Experience - Years in Practice"]),
        'min_price' => min_price_data(row["Monthly Membership Fee for Patient"]),
        'max_price' => max_price_data(row["Monthly Membership Fee for Patient"]),
        'min_patients' => min_patients_data(row["Maximum Patient Limit in Your Panel"]),
        'max_patients' => max_patients_data(row["Maximum Patient Limit in Your Panel"]),

        # 'email' => email_data(row["Doctor's Email Address"]),
        # 'phone' => phone_data(row["Contact Number"]),
        # 'website_url' => website_url_data(row["Website URL (if any)"]),
        'language' => language_data(row["Languages Spoken (Check all that apply)"]),
        # 'aditional_services' => aditional_services_data(row["Additional Services (Check all that apply)"]),
      }
    end

    ActiveRecord::Base.transaction do
      Doctor.create!(records)
    end

    puts 'imported'
  end

  def address_line_1(text)
    if text.present?
      text
    else
      'NA'
    end
  end

  def city_data(data)
    if data.present?
      data
    else
      "NA"
    end
  end

  def practice_name_data(data)
    if data.present?
      data
    else
      "Not Available"
    end
  end

  def about_clinic(data)
    if data.present?
      data
    else
      "Not Available"
    end
  end

  def about_doctor(data)
    if data.present?
      data
    else
      "Not Available"
    end
  end

  def process_aditional_services(row)
    if row["Additional Services (Check all that apply)"].present?
      aditional_services_data(row["Additional Services (Check all that apply)"])
    else
      aditional_services(row['Tags'])
    end
  end

  def aditional_services_data(data)
    if data.present?
      data&.gsub(";", ',')
    else
      'Not Available'
    end
  end

  def language_data(data)
    if data.present?
      data&.gsub(";", ',')
    else
      'Not Available'
    end
  end

  def website_url_data(data)
    if data.present?
      data.downcase
    end
  end

  def email_data(data)
    if data.present?
      data.downcase
    end
  end

  def phone_data(data)
    if data.present?
      data
    end
  end

  def free_consultation_time_data(data)
    if data.present?
      data
    else
      ''
    end
  end

  def consultation_data(data)
    if data.present?
      data
    else
      'Not Available'
    end
  end

  def appointments_data(data)
    if data.present?
      data&.gsub(";", ',')
    else
      'Not Available'
    end
  end

  def access_data(data)
    if data.present?
      data
    else
      'Not Available'
    end
  end

  def home_visit_option_data(data)
    if data.present?
      data
    else
      ''
    end
  end

  def is_home_visit_data(data)
    if data.present?
      data
    else
      'Not Available'
    end
  end

  def telehealth_option_data(data)
    if data.present?
      data
    else
      ''
    end
  end

  def is_telehealth_service_data(data)
    if data.present?
      data
    else
      'Not Available'
    end
  end

  def holistic_option_data(data)
    if data.present?
      data
    else
      ''
    end
  end

  def is_holistic_medicine_data(data)
    if data.present?
      data
    else
      'Not Available'
    end
  end

  def min_experience_data(data)
    if data.present?
      min_experience(data)
    else
      'Not Available'
    end
  end

  def max_experience_data(data)
    if data.present?
      max_experience(data)
    else
      'Not Available'
    end
  end

  def min_price_data(data)
    if data.present?
      min_price(data)
    else
      'Not Available'
    end
  end

  def max_price_data(data)
    if data.present?
      max_price(data)
    else
      'Not Available'
    end
  end

  def min_patients_data(data)
    if data.present?
      min_patients(data)
    else
      'Not Available'
    end
  end

  def max_patients_data(data)
    if data.present?
      max_patients(data)
    else
      'Not Available'
    end
  end

  def min_experience(experience)
    experience.split('-')&.first&.strip
  end

  def max_experience(experience)
    experience.split('-')&.last&.to_i
  end

  def min_price(price)
    price.split('-')&.first&.gsub("$", '')&.to_i
  end

  def max_price(price)
    price.split('-')&.last&.gsub("$", '')&.to_i
  end

  def min_patients(patients)
    patients.split('-')&.first&.to_i
  end

  def max_patients(patients)
    patients.split('-')&.last&.to_i
  end

  def to_jsonb(text)
    if text.present?
      list_items = text.split("\n")
      social_links = []
      list_items.each do |list_item|
        social_links << {
          "social_link" => list_item,
        }
      end
      social_links
    else
      "NA"
    end
  end

  def strip_html_tags(html)
    ActionController::Base.helpers.strip_tags(html)
  end

  def other_specialities(text)
    specialities = text.split("\n")
    data = []
    specialities.each do |speciality|
      speciality_data = Speciality.find_by_code(speciality)
      if speciality_data.present?
        data << speciality_data.code
      end
    end

    data.join(",")
  end

  def aditional_services(text)
    services = text.split("\n")
    data = []
    services.each do |service|
      service_data = Service.find_by_name(service)
      if service_data.present?
        data << service_data.name
      end
    end
    if data.present?
      data.join(",")
    else
      "Not Available"
    end
  end

  def primary_email(email_text)
    if email_text.present?
      emails = email_text.split("\n")
      emails.first.strip
    else
      "NA"
    end
  end

  def alternate_emails(email_text)
    if email_text.present?
      emails = email_text&.split("\n")&.drop(1)
      alt_emails = []
      emails.each do |email|
        alt_emails << {
          "alt_email" => email,
        }
      end
      alt_emails
    else
      "NA"
    end
  end

  def primary_phone(phone_text)
    if phone_text.present?
      phones = phone_text.split("\n")
      phones.first.strip
    else
      'NA'
    end
  end

  def alternate_phones(phone_text)
    if phone_text.present?
      phones = phone_text&.split("\n")&.drop(1)
      alt_phones = []
      phones.each do |phone|
        alt_phones << {
          "alt_phone" => phone,
        }
      end
      alt_phones
    end
  end

  def active_licenses(license_text)
    cities = "\n#{license_text}".split("\n")
    cities.map(&:strip)
  end

  def disciplinary_action_taken(text)
    master_data = [
      "Yes",
      "No",
      "No Actions Found",
      "Unable to verify",
    ]

    if master_data.include?(text)
      text
    else
      "Unable to verify"
    end
  end

  def doctor_name(doctor_text)
    if doctor_text.present?
      doctor_text.split(",")&.first
    else
      "NA"
    end
  end

  def doctor_title(doctor_text)
    if doctor_text.present?
      title = doctor_text.split(",")&.drop(1)
      if title.present?
        title.join(",")
      else
        "NA"
      end
    else
      "NA"
    end
  end
end
