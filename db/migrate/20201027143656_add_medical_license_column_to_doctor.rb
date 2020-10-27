class AddMedicalLicenseColumnToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :active_licenses, :string, array: true)
    add_column(:doctors, :disciplinary_action_taken, :text)
  end
end
