class CreateTopicTips < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_tips do |t|
      t.references(:topic, null: false, index: true, foreign_key: true)
      t.references(:tip, null: false, index: true, foreign_key: true)
      t.integer(:position, default: 0)

      t.timestamps
    end
  end
end
