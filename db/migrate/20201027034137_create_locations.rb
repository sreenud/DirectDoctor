class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table(:locations) do |t|
      t.references(:state, null: false, index: true, foreign_key: true)
      t.string(:name)
      t.string(:county)
      t.string(:state_code)
      t.string(:state)
      t.string(:zip_codes)
      t.string(:location_type)
      t.string(:latitude)
      t.string(:longitude)
      t.string(:area_code)
      t.string(:population)
      t.string(:households)
      t.string(:median_income)
      t.string(:land_area)
      t.string(:water_area)
      t.string(:time_zone)

      t.timestamps
    end
  end
end
