class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table(:likes) do |t|
      t.integer(:user_id)
      t.integer(:doctor_id)

      t.timestamps
    end

    add_index(:likes, :user_id)
    add_index(:likes, :doctor_id)
  end
end
