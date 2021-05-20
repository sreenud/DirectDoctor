class ChangePopulationFieldTypeInLocation < ActiveRecord::Migration[6.0]
  def change
    add_column(:locations, :people, :integer)
  end
end
