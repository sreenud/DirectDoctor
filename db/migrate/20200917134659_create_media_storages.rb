class CreateMediaStorages < ActiveRecord::Migration[6.0]
  def change
    create_table :media_storages do |t|
      t.text(:image_data)

      t.timestamps
    end
  end
end
