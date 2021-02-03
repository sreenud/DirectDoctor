class AddDataChangeToApprovalRequest < ActiveRecord::Migration[6.0]
  def change
    add_column(:approval_requests, :data_changes, :jsonb, default: {})
  end
end
