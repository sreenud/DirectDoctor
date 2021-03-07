class CreateLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :leads do |t|
      t.string(:email, null: false)
      t.string(:ip_address, null: true)
      t.string(:status, null: false, default: 'active')

      t.timestamps
    end
  end
end
