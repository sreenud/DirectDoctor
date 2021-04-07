class CreateStates < ActiveRecord::Migration[6.0]
  def change
    create_table(:states) do |t|
      t.string(:name)
      t.string(:code)
      t.string(:status, default: "active")

      t.timestamps
    end
  end
end
