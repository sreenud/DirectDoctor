class CreateTopics < ActiveRecord::Migration[6.0]
  def change
    create_table(:topics) do |t|
      t.string(:name)
      t.string(:slug)
      t.text(:summary)
      t.text(:content)
      t.boolean(:is_popular, default: 0)
      t.integer(:author_id)
      t.string(:meta_title)
      t.jsonb(:meta_keywords, default: {})
      t.text(:meta_description)
      t.string(:h1_tag)
      t.text(:image_data)
      t.string(:status)

      t.timestamps
    end

    add_index(:topics, :slug, unique: true)
  end
end
