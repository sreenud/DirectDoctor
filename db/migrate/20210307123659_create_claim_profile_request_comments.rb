class CreateClaimProfileRequestComments < ActiveRecord::Migration[6.0]
  def change
    create_table(:claim_profile_comments) do |t|
      t.integer(:claim_profile_request_id, null: false)
      t.integer(:user_id, null: false)
      t.text(:comment, null: false)

      t.timestamps

      t.index(:claim_profile_request_id)
      t.index(:user_id)
    end
  end
end
