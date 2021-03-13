class AddIndexRequestTokenToClaimProfileRequest < ActiveRecord::Migration[6.0]
  def change
    add_index(:claim_profile_requests, :request_token, unique: true)
  end
end
