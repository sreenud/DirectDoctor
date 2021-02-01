class CreateClaimProfileRequest < ActiveRecord::Migration[6.0]
  def change
    create_table(:claim_profile_requests) do |t|
      t.references(:user, null: false, foreign_key: true)
      t.integer(:doctor_id)
      t.string(:profile_name)
      t.string(:status)
      t.timestamps
    end
  end
end
