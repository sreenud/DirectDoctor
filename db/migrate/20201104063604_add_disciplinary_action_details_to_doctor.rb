class AddDisciplinaryActionDetailsToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :disciplinary_action_details, :text)
    change_column(:doctors, :prices, :text, default: :null)
    change_column(:doctors, :patients_in_panel, :text, default: :null)

  end
end
