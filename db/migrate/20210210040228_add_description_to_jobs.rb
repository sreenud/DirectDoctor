class AddDescriptionToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column(:jobs, :description, :text)
  end
end
