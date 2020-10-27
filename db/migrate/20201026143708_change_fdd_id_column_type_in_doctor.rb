class ChangeFddIdColumnTypeInDoctor < ActiveRecord::Migration[6.0]
  def change
    change_column(:doctors, :fdd_id, :string, null: true)
  end
end
