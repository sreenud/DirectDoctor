class AddDocumentDataToProfileRequestComment < ActiveRecord::Migration[6.0]
  def change
    add_column(:claim_profile_comments, :document_data, :text)
  end
end
