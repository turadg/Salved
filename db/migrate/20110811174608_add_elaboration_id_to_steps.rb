class AddElaborationIdToSteps < ActiveRecord::Migration
  def change
    add_column :steps, :elaboration_id, :integer
  end
end
