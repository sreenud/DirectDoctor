class CreateSurveys < ActiveRecord::Migration[6.0]
  def change
    create_table(:surveys) do |t|
      t.string(:email)
      t.text(:survey)

      t.timestamps
    end
  end
end
