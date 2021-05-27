class CreateNewsLetter < ActiveRecord::Migration[6.0]
  def change
    create_table(:news_letters) do |t|
      t.string(:email)

      t.timestamps
    end
  end
end
