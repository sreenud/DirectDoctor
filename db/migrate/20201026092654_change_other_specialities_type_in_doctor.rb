class ChangeOtherSpecialitiesTypeInDoctor < ActiveRecord::Migration[6.0]
  def change
    remove_column(:doctors, :other_specialities)

    add_column(:doctors, :other_specialities, :string, array: true)
  end
end
