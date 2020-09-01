class CreateTips < ActiveRecord::Migration[6.0]
  def change
    create_table :tips do |t|
      t.string(:name)
      t.string(:slug)
      t.string(:code)
      t.text(:summary)
      t.text(:content)
      t.integer(:author_id)
      t.string(:meta_title)
      t.jsonb(:meta_keywords)
      t.text(:meta_description)
      t.string(:h1_tag)
      t.text(:image_data)
      t.string(:status)

      t.timestamps
    end

    add_index(:tips, :slug, unique: true)
    add_index(:tips, :code, unique: true)
  end
end
