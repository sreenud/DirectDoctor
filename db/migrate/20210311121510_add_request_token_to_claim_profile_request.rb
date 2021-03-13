class AddRequestTokenToClaimProfileRequest < ActiveRecord::Migration[6.0]
  def change
    add_column(:claim_profile_requests, :request_token, :string)
  end
end
