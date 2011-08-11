class AddUnderstoodToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :understood, :boolean
  end
end
