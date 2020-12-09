class AddSpecialityToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :speciality_id, :integer, index: true)
  end
end
