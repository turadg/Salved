class AddProblemIdToElaboration < ActiveRecord::Migration
  def change
    add_column :elaborations, :problem_id, :integer
  end
end
