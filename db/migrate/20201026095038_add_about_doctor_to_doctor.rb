class AddAboutDoctorToDoctor < ActiveRecord::Migration[6.0]
  def change
    remove_column(:doctors, :practice_details)

    add_column(:doctors, :about_doctor, :text)
    add_column(:doctors, :about_clinic, :text)
  end
end
