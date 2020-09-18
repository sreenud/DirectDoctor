class AddReadTimeToTopic < ActiveRecord::Migration[6.0]
  def change
    add_column(:topics, :read_time, :integer)
  end
end
