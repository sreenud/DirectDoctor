namespace :doctor_fmdd do
  task update_code: :environment do
    doctors = Doctor.where(state: "Puerto Rico")

    doctors.each do |doctor|
      doctor.fdd_id = "PR#{doctor.fdd_id}"
      doctor.save

      puts "#{doctor.name}"
    end
  end

  task update_code_ga: :environment do
    doctors = Doctor.where(state: "Georgia")

    doctors.each do |doctor|
      fdd_id = doctor.fdd_id.split("-")
      unless fdd_id.include? "GA"
        doctor.fdd_id = "GA#{doctor.fdd_id}"
        doctor.save
      end

      puts "#{doctor.fdd_id}"
    end
  end
end
