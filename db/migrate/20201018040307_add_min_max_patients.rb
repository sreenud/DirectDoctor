class AddMinMaxPatients < ActiveRecord::Migration[6.0]
  def change
    remove_column(:doctors, :max_patients_in_panel)

    add_column(:doctors, :patients_in_panel, :string)
    add_column(:doctors, :min_patients, :integer)
    add_column(:doctors, :max_patients, :integer)
  end
end
