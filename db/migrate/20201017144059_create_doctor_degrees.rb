class CreateDoctorDegrees < ActiveRecord::Migration[6.0]
  def change
    create_table :doctor_degrees do |t|
      t.string(:name)
      t.string(:code, index: true, unique: true)
      t.string(:status, default: 'active')

      t.timestamps
    end
  end
end
