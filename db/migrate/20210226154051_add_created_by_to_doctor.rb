class AddCreatedByToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :created_by, :integer)
    add_column(:doctors, :updated_by, :integer)
  end
end
