class AddLatLngToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :lat, :string)
    add_column(:doctors, :lng, :string)
  end
end
