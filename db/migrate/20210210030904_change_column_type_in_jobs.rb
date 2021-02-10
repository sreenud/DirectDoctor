class ChangeColumnTypeInJobs < ActiveRecord::Migration[6.0]
  def change
    change_column(:jobs, :salary, :text)
    change_column(:jobs, :sign_on_bonus, :text)
  end
end
