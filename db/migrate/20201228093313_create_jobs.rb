class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.references(:doctor, null: false, index: true, foreign_key: true)
      t.integer(:specialities, array: true)
      t.string(:name)
      t.string(:board_certification)
      t.string(:hours)
      t.string(:experience)
      t.integer(:salary)
      t.integer(:sign_on_bonus)
      t.string(:paid_time_off)
      t.string(:loan_assistance)
      t.string(:health_insurence)
      t.string(:medical_insurence)
      t.string(:visa_sponsorship)
      t.text(:resume_data)
      t.jsonb(:degree, default: {})
      t.string(:status)
      t.timestamps
    end
  end
end
