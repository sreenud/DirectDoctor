class ChangeLanguageFieldType < ActiveRecord::Migration[6.0]
  def change
    remove_column(:doctors, :language)

    add_column(:doctors, :language, :string)
  end
end
