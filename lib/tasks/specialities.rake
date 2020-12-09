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
end
