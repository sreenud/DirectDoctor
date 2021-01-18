class CreateClaimProfileAttachment < ActiveRecord::Migration[6.0]
  def change
    create_table :claim_profile_attachments do |t|
      t.references(:claim_profile_request, null: false, foreign_key: true)
      t.text(:image_data)
      t.string(:status)

      t.timestamps
    end
  end
end
