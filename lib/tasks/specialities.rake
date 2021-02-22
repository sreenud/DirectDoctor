namespace :specialities do
  desc "Import Specialities"
  task update: :environment do
    doctors = CSV.open(Rails.public_path.join('doctors.csv'), headers: :first_row).map(&:to_h)

    doctors.each do |doctor|
      doctor_obj = Doctor.find_by_old_fdd_id(doctor['fdd_id'])

      doctor_obj.other_specialities = doctor['speciality']
      doctor_obj.aditional_services = doctor['service']
      doctor_obj.save

      puts doctor['speciality']
      puts doctor['service']
    end

    puts "States and cities import is completed"
  end

  desc "Import Specialities"
  task update_speciality_id: :environment do
    doctors = Doctor.all

    doctors.each do |doctor|
      doctor_obj = Speciality.find_by_code(doctor.primary_speciality)
      if doctor_obj.present?
        doctor.speciality_id = doctor_obj.id
        doctor.save
      end
    end

    puts "Speciality id is updated in doctors"
  end
  desc "Update Specialities slug"
  task update_slug: :environment do
    specialities = Speciality.all
    specialities.each do |speciality|
      speciality.slug = speciality.name.parameterize
      speciality.save

      puts "#{speciality.name} slug updated"
    end
  end
end
