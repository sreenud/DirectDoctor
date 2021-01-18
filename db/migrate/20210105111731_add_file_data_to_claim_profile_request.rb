class AddFileDataToClaimProfileRequest < ActiveRecord::Migration[6.0]
  def change
    add_column(:claim_profile_requests, :document_data, :text)
  end
end
