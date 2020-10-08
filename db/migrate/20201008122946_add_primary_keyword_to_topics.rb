class AddPrimaryKeywordToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column(:topics, :primary_keyword, :string)
    add_index(:topics, :primary_keyword, unique: true)
  end
end
