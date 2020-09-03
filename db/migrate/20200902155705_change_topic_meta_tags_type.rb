class ChangeTopicMetaTagsType < ActiveRecord::Migration[6.0]
  def change
    remove_column(:topics, :meta_keywords)
    add_column(:topics, :meta_keywords, :string)
  end
end
