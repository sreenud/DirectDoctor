class AddStatusToTopic < ActiveRecord::Migration[6.0]
  def change
    add_column(:topics, :status, :string)
    add_column(:tips, :status, :string)
  end
end
