class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.references(:doctor, null: false, index: true, foreign_key: true)
      t.string(:name)
      t.string(:email)
      t.integer(:rating)
      t.string(:title)
      t.text(:review)
      t.string(:treated_by_doctor)
      t.string(:will_you_recommend)
      t.string(:anonymous)
      t.string(:status, default: 'draft')

      t.timestamps
    end
  end
end
