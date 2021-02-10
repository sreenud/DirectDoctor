class AddDesiredSkillsToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column(:jobs, :desired_skills, :string)
  end
end
