class AddSlugToStates < ActiveRecord::Migration[6.0]
  def change
    add_column(:states, :slug, :string)
  end
end
