class CreateSpecialityAlias < ActiveRecord::Migration[6.0]
  def change
    create_table :speciality_aliases do |t|
      t.references(:speciality, null: false, index: true, foreign_key: true)
      t.string(:speciality_code, index: true)
      t.string(:name)

      t.timestamps
    end
  end
end
