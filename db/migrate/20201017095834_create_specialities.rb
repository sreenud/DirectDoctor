class CreateSpecialities < ActiveRecord::Migration[6.0]
  def change
    create_table(:specialities) do |t|
      t.string(:name)
      t.string(:code, unique: true, index: true)
      t.string(:status, default: 'active')

      t.timestamps
    end
  end
end
