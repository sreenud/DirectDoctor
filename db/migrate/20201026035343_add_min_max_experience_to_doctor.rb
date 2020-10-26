class AddMinMaxExperienceToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :min_experience, :integer, default: 0)
    add_column(:doctors, :max_experience, :integer, default: 0)

    remove_column(:doctors, :experience)
  end
end
