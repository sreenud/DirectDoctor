class AddFddIdAlternateEmailToDoctor < ActiveRecord::Migration[6.0]
  def change
    add_column(:doctors, :alternate_emails, :jsonb, default: {})
    add_column(:doctors, :alternate_phones, :jsonb, default: {})
    add_column(:doctors, :old_fdd_id, :string)
    add_column(:doctors, :contact_us_url, :string)
  end
end
