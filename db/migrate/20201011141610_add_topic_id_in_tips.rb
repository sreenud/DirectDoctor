class AddTopicIdInTips < ActiveRecord::Migration[6.0]
  def change
    add_reference(:tips, :topic, index: true)
  end
end
