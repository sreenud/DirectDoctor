class AddCategoryToTopics < ActiveRecord::Migration[6.0]
  def change
    add_reference(:topics, :category, index: true)
    add_column(:tips, :related_topics, :integer, array: true)
  end
end
