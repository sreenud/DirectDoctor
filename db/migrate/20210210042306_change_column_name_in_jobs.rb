class ChangeColumnNameInJobs < ActiveRecord::Migration[6.0]
  def change
    rename_column(:jobs, :name, :title)
  end
end
