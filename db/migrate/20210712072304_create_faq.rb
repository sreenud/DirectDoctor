class CreateFaq < ActiveRecord::Migration[6.0]
  def change
    create_table :faqs do |t|
      t.string(:name)
      t.string(:slug)
      t.string(:code)
      t.text(:content)
      t.string(:meta_title)
      t.jsonb(:meta_keywords)
      t.text(:meta_description)
      t.string(:h1_tag)
      t.string(:status)

      t.timestamps
    end

    add_index(:faqs, :slug, unique: true)
    add_index(:faqs, :code, unique: true)
  end
end
