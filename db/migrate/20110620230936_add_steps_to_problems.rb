class AddStepsToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :step_count, :integer
    add_column :problems, :explanations, :text
  end
end
