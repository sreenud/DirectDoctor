class ChangeHealthCareColumnTypeInDoctor < ActiveRecord::Migration[6.0]
  def change
    change_column(:doctors, :is_holistic_medicine, :string)
    change_column(:doctors, :is_telehealth_service, :string)
    change_column(:doctors, :is_home_visit, :string)
  end
end
