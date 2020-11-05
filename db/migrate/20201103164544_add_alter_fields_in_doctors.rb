class AddAlterFieldsInDoctors < ActiveRecord::Migration[6.0]
  def change
    change_column(:doctors, :prices, :text)
    change_column(:doctors, :patients_in_panel, :text)
  end
end
