class ChangeLatLngInDoctors < ActiveRecord::Migration[6.0]
  def change
    column_type = proc do |name|
      "decimal USING CAST(COALESCE(NULLIF(#{name},''), '0.0') AS decimal)"
    end
    change_column(:doctors, :lat, column_type.call('lat'), precision: 15, scale: 6)
    change_column(:doctors, :lng, column_type.call('lng'), precision: 15, scale: 6)
  end
end
