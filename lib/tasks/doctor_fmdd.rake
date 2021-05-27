namespace :doctor_fmdd do
  task update_code: :environment do
    doctors = Doctor.where(state: "Puerto Rico")

    doctors.each do |doctor|
      doctor.fdd_id = "PR#{doctor.fdd_id}"
      doctor.save

      puts "#{doctor.name}"
    end
  end
end
