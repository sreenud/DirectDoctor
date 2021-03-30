class AddIsReadToClaimProfileComment < ActiveRecord::Migration[6.0]
  def change
    add_column(:claim_profile_comments, :is_read, :boolean, default: false)
  end
end
