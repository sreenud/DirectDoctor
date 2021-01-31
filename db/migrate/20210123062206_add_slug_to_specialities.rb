class AddSlugToSpecialities < ActiveRecord::Migration[6.0]
  def change
    add_column(:specialities, :slug, :string)
  end
end
