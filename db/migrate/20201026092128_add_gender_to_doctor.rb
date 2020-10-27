class AddGenderToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :gender, :string)
  end
end
