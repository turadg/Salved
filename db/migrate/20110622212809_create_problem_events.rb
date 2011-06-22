class CreateProblemEvents < ActiveRecord::Migration
  def change
    create_table :problem_events do |t|
      t.integer :problem_id
      t.integer :step
      t.string :name
      t.text :value
      t.string :ip_address

      t.timestamps
    end
  end
end
