class AddLatLngToStates < ActiveRecord::Migration[6.0]
  def change
    add_column(:states, :lat, :float)
    add_column(:states, :lng, :float)
  end
end
