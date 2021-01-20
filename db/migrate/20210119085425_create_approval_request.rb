class CreateApprovalRequest < ActiveRecord::Migration[6.0]
  def change
    create_table :approval_requests do |t|
      t.integer(:request_user_id, null: false)
      t.integer(:respond_user_id)
      t.text(:params)
      t.integer(:status, null: false, default: 0, limit: 1)
      t.datetime(:requested_at, null: false)
      t.datetime(:approved_at)
      t.datetime(:rejected_at)

      t.timestamps

      t.index(:request_user_id)
      t.index(:respond_user_id)
      t.index(:status)
    end

    create_table :approval_comments do |t|
      t.integer(:request_id, null: false)
      t.integer(:user_id, null: false)
      t.text(:content, null: false)

      t.timestamps

      t.index(:request_id)
      t.index(:user_id)
    end
  end
end
