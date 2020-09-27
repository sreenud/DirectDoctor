class AddImageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :image_data, :text, null: true)
    add_column(:users, :about, :text, null: true)
    add_column(:users, :title, :string, null: true)
  end
end
