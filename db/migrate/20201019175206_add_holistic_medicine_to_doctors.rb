class AddHolisticMedicineToDoctors < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :is_holistic_medicine, :boolean)
    add_column(:doctors, :holistic_option, :string)
    add_column(:doctors, :is_telehealth_service, :boolean)
    add_column(:doctors, :telehealth_option, :string)
    add_column(:doctors, :is_home_visit, :boolean)
    add_column(:doctors, :home_visit_option, :string)
    add_column(:doctors, :aditional_services, :string)

    remove_column(:doctors, :appointments)
    add_column(:doctors, :appointments, :string)
  end
end
