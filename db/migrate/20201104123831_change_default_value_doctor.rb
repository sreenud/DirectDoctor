class ChangeDefaultValueDoctor < ActiveRecord::Migration[6.0]
  def change
    change_column(:doctors, :prices, :text, default: '')
    change_column(:doctors, :patients_in_panel, :text, default: '')
  end
end
